//
//  RoomCaptureBridgeController.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 23/05/23.
//

import Foundation

class RoomCaptureBridgeController: ObservableObject {
    var RoomCaptureViewController_: RoomCaptureViewController!
    
    @Published var FloorPlanTitle_: String = ""
    @Published var ExportButtonHidden_: Bool = true
}
