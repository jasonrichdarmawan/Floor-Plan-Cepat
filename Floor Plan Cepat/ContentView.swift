//
//  ContentView.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var router_: Router
    @EnvironmentObject private var roomCaptureBridgeController_: RoomCaptureBridgeController
    
    init() {
#if DEBUG
        print("\(String(describing: ContentView.self)) initialized")
#endif
    }
    
    var body: some View {
        // TODO: fix `Update NavigationAuthority bound path tried to update multiple times per frame.`
        NavigationStack(path: self.$router_.Path_) {
            EmptyView()
                .navigationDestination(for: Router.Feature.self) { destination in
                    switch destination {
                    case .FloorPlanListView:
                        FloorPlanListView()
                            .navigationTitle("Daftar Floor Plan")
                            .navigationBarBackButtonHidden(true)
                    case .CameraView:
                        CameraView()
                        // to hide navigationTitle
                        // by inlining the navigation title with the navigation bar back button
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden(true)
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarLeading, content: {
                                    Button(
                                        action: {
                                            self.router_.Path_.removeLast()
                                        },
                                        label: {
                                            Image(systemName: "chevron.left")
                                        }
                                    )
                                })
                                ToolbarItem(placement: .navigationBarLeading, content: {
                                    TextField("Nama Floor Plan?", text: self.$roomCaptureBridgeController_.FloorPlanTitle_)
                                })
                                if self.roomCaptureBridgeController_.ExportButtonHidden_ {
                                    ToolbarItem(placement: .navigationBarTrailing, content: {
                                        Button(
                                            action: {
                                                self.roomCaptureBridgeController_.RoomCaptureViewController_.doneScanning()
                                            },
                                            label: {
                                                Text("Done")
                                            }
                                        )
                                    })
                                }
                            })
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let router: Router = Router(path: NavigationPath([Router.Feature.FloorPlanListView]))
        let floorPlans: FloorPlans = FloorPlans(FloorPlans_: [FloorPlan(title: "Studento L20/2")])
        let roomCaptureBridgeController: RoomCaptureBridgeController = RoomCaptureBridgeController()
        
        ContentView()
            .environmentObject(router)
            .environmentObject(floorPlans)
            .environmentObject(roomCaptureBridgeController)
    }
}
