//
//  Redux.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI

class FloorPlans: ObservableObject {
    @Published var FloorPlans_: [FloorPlan]
    
    init(FloorPlans_: [FloorPlan] = []) {
        self.FloorPlans_ = FloorPlans_
    }
}
