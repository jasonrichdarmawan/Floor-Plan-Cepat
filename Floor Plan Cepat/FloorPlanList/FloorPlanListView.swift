//
//  FloorPlanListView.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI

struct FloorPlanListView: View {
    @EnvironmentObject private var router_: Router
    @EnvironmentObject private var floorPlans_: FloorPlans
    
    init() {
#if DEBUG
        print("\(String(describing: FloorPlanListView.self)) initialized")
#endif
    }
    
    var body: some View {
        NavigationStack(path: self.$router_.Path_) {
            List(self.floorPlans_.FloorPlans_) { floorPlan in
                NavigationLink {
                    FloorPlanView(floorPlan: floorPlan)
                } label: {
                    Text(floorPlan.title)
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    self.router_.Path_.append(Router.Feature.CameraView)
                }, label: {
                    // TODO: fix Text background to conform with the View background.
                    Text("Tambah Floor Plan").padding(.horizontal)
                })
            }
        }.onAppear {
#if DEBUG
            print("\(String(describing: FloorPlanListView.self)) appeared")
#endif
        }.onDisappear {
#if DEBUG
            print("\(String(describing: FloorPlanListView.self)) disappeared")
#endif
        }
    }
}

struct FloorPlanListView_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router()
        let floorPlans = FloorPlans(FloorPlans_: [FloorPlan(title: "Studento L20/2")])
        FloorPlanListView()
            .environmentObject(router)
            .environmentObject(floorPlans)
    }
}
