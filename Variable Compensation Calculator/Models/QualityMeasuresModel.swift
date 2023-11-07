//
//  QualityMeasuresModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/23/23.
//

import Foundation
import SwiftUI
import OSLog

@Observable
class QualityMeasuresModel {
    var acuteClinicalOutcomeScore: Int? {
        didSet {
            saveAcuteClinicalOutcomeScore()
        }
    }
    private let acuteClinicalOutcomeScoreKey = "AcuteClinicalOutcomeScore"
    
    var qualityPoints: Int {
        guard let acuteClinicalOutcomeScore else { return 0 }
        guard acuteClinicalOutcomeScore > 50 else { return 0 }
        guard acuteClinicalOutcomeScore <= 100 else { return 50 }
        
        return acuteClinicalOutcomeScore - 50
    }
    
    var prompt: String? {
        guard let acuteClinicalOutcomeScore else { return nil }
        switch acuteClinicalOutcomeScore {
        case ...50:
            return "No points earned until a minumum acute care clinical outcome score of 50"
        case 66...:
            return "Maximum of 50 points earned after acute care clinical outcome score of 100"
        default:
            return nil
        }
    }
    
    var calculation: String? {
        guard let acuteClinicalOutcomeScore else { return nil }
        guard acuteClinicalOutcomeScore > 50 && acuteClinicalOutcomeScore <= 100 else { return nil }
        return "(Score of \(acuteClinicalOutcomeScore) - 50 minimum) x 1 VC point / point"
    }
    
    var description: LocalizedStringKey {
        """
        A maximum of 50 points of the eligible Quality/VBP VC will be based upon the Prisma Health Overall Quality and Safety Acute Care Quality Score. This component of VC is a group metric. The Department of Emergency Medicine recognizes that we play a pivotal role in overall quality of health care delivered in our health systems. Prisma Health has developed a robust Quality and Safety reporting system. The Acute Care Quality performance is measured and weighted (40%) of the overall Quality and Patient safety dashboard. The goal is an Acute Clinical outcome score of 100. The group will earn 1 VC point per point of Acute Care Clinical outcome score above 50 to a score of 100 (a maximum of 50 points).
        """
    }
    
    func saveAcuteClinicalOutcomeScore() {
        if let acuteClinicalOutcomeScore {
            UserDefaults.standard.set(acuteClinicalOutcomeScore, forKey: acuteClinicalOutcomeScoreKey)
        } else {
            Logger.model.info("acuteClinicalOutcomeScore is nil. acuteClinicalOutcomeScore must have a value to save to UserDefaults")
        }
    }
    
    func loadAcuteClinicalOutcomeScore() {
        self.acuteClinicalOutcomeScore = UserDefaults.standard.object(forKey: acuteClinicalOutcomeScoreKey) as? Int
    }
}
