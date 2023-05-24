//
//  FloorPlanView.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI

struct FloorPlanView: View {
    private var floorPlan_: FloorPlan
    
    init(floorPlan: FloorPlan) {
        self.floorPlan_ = floorPlan
    }
    
    var body: some View {
        Text(self.floorPlan_.title)
    }
}
