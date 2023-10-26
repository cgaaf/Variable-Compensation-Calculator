//
//  ClinicalProductivityModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import Foundation
import SwiftUI
import OSLog

@Observable
class ClinicalProductivityModel {
    var rvuPercentile: Int?
    private let rvuPercentileKey = "RVUPercentile"
    
    init(rvuPercentile: Int? = nil) {
        self.rvuPercentile = rvuPercentile
    }
    
    var clinicalPoints: Int {
        guard let rvuPercentile else { return 0 }
        guard rvuPercentile > 40 else { return 0 } // Must meet minimum 35th percentile
        
        let _points = (rvuPercentile - 40) * 4 // Point accumulation starts after 35
        guard _points <= 100 else { return 100 } // Maximum of 100 clinical points
        
        return _points
    }
    
    var prompt: String? {
        guard let rvuPercentile else { return nil }
        switch rvuPercentile {
        case ..<40:
            return "No points earned until a minumum of 40th MGMA percentile met"
        case 66...:
            return "Maximum of 100 points earned after 65th MGMA percentile met"
        default:
            return nil
        }
    }
    
    var description: LocalizedStringKey {
        """
        A maximum of 100 points of the eligible total Quality/VBP VC will be based upon Clinician productivity as represented by RVUs/hour. This component of VC is an **individual** metric. This metric will be based upon the most recently published market productivity data (compared to a 1.0 FTE).
        
        The Department’s minimum standard of clinical productivity is the 40th percentile of market data. Any clinician ≤40th percentile of market data will forfeit their clinical productivity VC. At the 41st percentile and greater, clinicians will earn 4 VC points per percentile to the 65th percentile (a maximum of 100 points).
        """
    }
    
    var calculation: String? {
        guard let rvuPercentile else { return nil }
        guard rvuPercentile > 40 && rvuPercentile <= 65 else { return nil }
        return "(\(rvuPercentile)th percentile - 40th minimum) x 4 points/%"
    }
    
    func saveRVUPercentile() {
        if let rvuPercentile {
            UserDefaults.standard.setValue(rvuPercentile, forKey: rvuPercentileKey)
        } else {
            Logger.model.info("rvuPercentile is currently nil. Save to UserDefaults only when a value is present")
        }
    }
    
    func loadRVUPercentile() {
        self.rvuPercentile = UserDefaults.standard.object(forKey: rvuPercentileKey) as? Int
    }
}
