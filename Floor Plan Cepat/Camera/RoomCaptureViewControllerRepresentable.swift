//
//  RoomCaptureViewControllerRepresentable.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/05/23.
//

import SwiftUI

struct RoomCaptureViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject private var roomCaptureBridgeController_: RoomCaptureBridgeController
    
    func makeUIViewController(context: Context) -> RoomCaptureViewController {
        let roomCaptureViewController = RoomCaptureViewController()
        roomCaptureViewController.RoomCaptureBridgeController_ = self.roomCaptureBridgeController_
        return roomCaptureViewController
    }
    
    func updateUIViewController(_ UIViewController: RoomCaptureViewController, context: Context) {
    }
}
