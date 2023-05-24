//
//  RoomCaptureViewController.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/05/23.
//

import UIKit
import RoomPlan

class RoomCaptureViewController: UIViewController, RoomCaptureViewDelegate, RoomCaptureSessionDelegate {
    var RoomCaptureBridgeController_: RoomCaptureBridgeController!
    
    private var isScanning: Bool = false
    
    private var roomCaptureView: RoomCaptureView!
    private var roomCaptureSessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
    private var finalResults: CapturedRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.RoomCaptureBridgeController_.RoomCaptureViewController_ = self
        
        // Set up after loading the view.
        setupRoomCaptureView()
    }
    
    private func setupRoomCaptureView() {
        roomCaptureView = RoomCaptureView(frame: view.bounds)
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
        
        // bug fix: the roomCaptureView is next to the Indicator bar if we use RoomCaptureViewControllerRepresentable in ZStack without ignoreSafeArea(.all)
        /*
         ZStack {
             RoomCaptureViewControllerRepresentable()
         }
         */
        // Adjust the Y position by adding a vertical offset
        let verticalOffset: CGFloat = -100 // Modify this value as needed
        roomCaptureView.frame = CGRect(x: 0, y: verticalOffset, width: view.bounds.width, height: view.bounds.height)
        
        view.insertSubview(roomCaptureView, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewWillDisappear(_ flag: Bool) {
        super.viewWillDisappear(flag)
        stopSession()
    }
    
    private func startSession() {
        isScanning = true
        roomCaptureView?.captureSession.run(configuration: roomCaptureSessionConfig)
    }
    
    private func stopSession() {
        isScanning = false
        roomCaptureView?.captureSession.stop()
        
        setCompleteNavBar()
    }
    
    // Decide to post-process and show the final results.
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        // bug fix: roomCaptureView can invoke .captureSession.stop() when the user put the phone face down.
        stopSession()
        
#if DEBUG
        print("\(#function) invoked")
#endif
        return true
    }
    
    // Access the final post-processed results.
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
    }
    
    func doneScanning() {
        print("\(#function) invoked")
        if isScanning { stopSession() }
    }

    // Export the USDZ output by specifying the `.parametric` export option.
    // Alternatively, `.mesh` exports a nonparametric file and `.all`
    // exports both in a single USDZ.
    // TODO: refactor method to only pop over the export menu.
    func exportResults(_ path: String) {
        var newPath = path
        
        if newPath.isEmpty {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd_MM_yyyy_HH_mm"
            let dateString = dateFormatter.string(from: currentDate)
            newPath = "Room_\(dateString)"
        }
        
        // TODO: save to a specific folder for later use
        let destinationURL = FileManager.default.temporaryDirectory.appending(path: "\(newPath).usdz")
        do {
            try finalResults?.export(to: destinationURL, exportOptions: .parametric)
            
            let activityVC = UIActivityViewController(activityItems: [destinationURL], applicationActivities: nil)
            activityVC.modalPresentationStyle = .popover
            
            present(activityVC, animated: true, completion: nil)
        } catch {
            print("Error = \(error)")
        }
    }
    
    private func setCompleteNavBar() {
        self.RoomCaptureBridgeController_.ExportButtonHidden_ = false
    }
}
