//
//  CameraView.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI
import RoomPlan

struct CameraView: View {
    @EnvironmentObject private var router_: Router
    
    @EnvironmentObject private var roomCaptureBridgeController_: RoomCaptureBridgeController
    
    init() {
#if DEBUG
        print("\(String(describing: CameraView.self)) initialized")
#endif
    }
    
    var body: some View {
        ZStack {
            RoomCaptureViewControllerRepresentable().ignoresSafeArea(.all)
            VStack {
                TextField("Nama Floor Plan?", text: self.$roomCaptureBridgeController_.FloorPlanTitle_)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Spacer()
                if !self.roomCaptureBridgeController_.ExportButtonHidden_ {
                    Button(action: {
                        self.roomCaptureBridgeController_.RoomCaptureViewController_.exportResults(self.roomCaptureBridgeController_.FloorPlanTitle_)
                    },
                           label: {
                        Text("Export")
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(32)
                    })
                    .preferredColorScheme(.dark)
                }
            }
        }.onAppear {
#if DEBUG
            print("\(String(describing: CameraView.self)) appeared")
#endif
        }.onDisappear {
#if DEBUG
            print("\(String(describing: CameraView.self)) disappeared")
#endif
        }
        .onTapGesture {
            // fix: the keyboard do not close when tapping outside the TextField
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router(path: NavigationPath([Router.Feature.CameraView]))
        let roomCaptureBridgeController = RoomCaptureBridgeController()
        CameraView()
            .environmentObject(router)
            .environmentObject(roomCaptureBridgeController)
    }
}
