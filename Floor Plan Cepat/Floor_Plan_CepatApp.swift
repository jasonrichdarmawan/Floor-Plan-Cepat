//
//  Floor_Plan_CepatApp.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI

@main
struct Floor_Plan_CepatApp: App {
    var body: some Scene {
        let router = Router(path: NavigationPath([Router.Feature.CameraView]))
        let floorPlans = FloorPlans(FloorPlans_: [FloorPlan(title: "Studento L20/2")])
        let roomCaptureBridgeController = RoomCaptureBridgeController()
        
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(floorPlans)
                .environmentObject(roomCaptureBridgeController)
        }
    }
}
