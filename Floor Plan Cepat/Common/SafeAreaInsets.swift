//
//  SafeAreaInsets.swift
//  Floor Plan Cepat
//
//  Created by Jason Rich Darmawan Onggo Putra on 25/05/23.
//

import UIKit

enum SafeAreaInsets {
    case IPHONE_14_PRO_MAX
    
    private var insets_: (portrait: UIEdgeInsets, landscape: UIEdgeInsets) {
        switch self {
        case .IPHONE_14_PRO_MAX:
            return (
                portrait: UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0),
                landscape: UIEdgeInsets(top: 0, left: 59, bottom: 21, right: 59)
            )
        // Add cases for other iPhone models if needed
        }
    }
    
    var Potrait_: UIEdgeInsets {
        return self.insets_.portrait
    }
    
    var Landscape_: UIEdgeInsets {
        return self.insets_.landscape
    }
}
