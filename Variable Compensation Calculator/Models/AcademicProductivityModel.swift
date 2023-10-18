//
//  AcademicProductivityModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import Foundation
import SwiftUI

@Observable
class AcademicProductivityModel {
    var academicRVUs: Int?
    
    init(initialAcademicRVUs: Int? = nil) {
        self.academicRVUs = initialAcademicRVUs
    }
    
    var academicPoints: Int {
        guard let academicRVUs else { return 0 } // No points when aRVU is nil
        guard academicRVUs > 20 else { return 0 } // No points until 20 aRVU threshold met
        
        let _points = (academicRVUs - 20) * 4 // Point calculation starts after 20
        guard _points <= 100 else { return 100 } // Maximum of 100 academic points
        
        return _points
    }
    
    let label = "aRVUs/year by individual metrics"
    
    var prompt: String? {
        guard let academicRVUs else { return nil }
        switch academicRVUs {
        case ..<20:
            return "No points earned until a minumum of 20 aRVUs met"
        case 46...:
            return "Maximum of 100 points earned after 45 aRVUs met"
        default:
            return nil
        }
    }
    
    var calculation: String? {
        guard let academicRVUs else { return nil }
        guard academicRVUs > 20 && academicRVUs <= 45 else { return nil }
//        let removedTwenty = academicRVUs - 20
        return "(\(academicRVUs) aRVUs - 20 minimum) x 4 points/aRVU"
    }
    
    var footerAlignment: HorizontalAlignment {
        if calculation != nil { return .trailing }
        return .leading
    }
    
    var description: String {
        "The Department's minimum standard of academic productivity is 20 aRVUs. Any physician earning ≤ 20 aRVUs will forfeit their academic productivity variable compensation. At 21 aRVUs, physicians will earn 4 VC points per aRVU to 45 aRVUs (a maximum of 100 points"
    }
}
