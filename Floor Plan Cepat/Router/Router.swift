//
//  NavigationFeatures.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 22/05/23.
//

import SwiftUI

class Router: ObservableObject {
    @Published var Path_: NavigationPath
    
    init(path: NavigationPath = NavigationPath([Router.Feature.FloorPlanListView])) {
        self.Path_ = path
    }
}
