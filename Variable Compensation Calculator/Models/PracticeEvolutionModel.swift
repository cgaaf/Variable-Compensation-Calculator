//
//  PracticeEvolutionModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/23/23.
//

import Foundation
import SwiftUI
import OSLog

@Observable
class PracticeEvolutionModel {
    var pepSmartGoalScore: Int = 1 {
        didSet {
            savePEPSmartGoal()
        }
    }
    private let pepSmartGoalScoreKey = "PEPSmartGoalScore"
    
    var pepTimeCommitment: Int = 4 {
        didSet {
            savePEPTimeCommitment()
        }
    }
    private let pepTimeCommitmentKey = "PEPTimeCommitmentKey"
    
    let smartGoalOptions = [1, 2, 3, 4, 5]
    let timeCommitmentOptions = [4, 6, 8, 10, 12, 14, 16, 18, 20, 22]
    
    var pepPoints: Int {
        switch (pepSmartGoalScore, pepTimeCommitment) {
        case let (score, time) where score <= 1 || time <= 4:
            return 0
        case let (score, time) where score <= 3 && time <= 4:
            return 0
        case let (score, time) where score <= 2 && time <= 6:
            return 0
        case let (score, time) where score <= 1 && time <= 12:
            return 0
        case let (score, time) where score <= 5 && time <= 6:
            return 25
        case let (score, time) where score <= 4 && time <= 8:
            return 25
        case let (score, time) where score <= 3 && time <= 12:
            return 25
        case let (score, time) where score <= 2 && time <= 18:
            return 25
        case let (score, time) where score <= 1 && time >= 14:
            return 25
        case let (score, time) where score <= 5 && time <= 12:
            return 50
        case let (score, time) where score <= 4 && time <= 14:
            return 50
        case let (score, time) where score <= 3 && time <= 20:
            return 50
        case let (score, time) where score <= 2 && time >= 10:
            return 50
        case let (score, time) where score <= 5 && time <= 16:
            return 75
        case let (score, time) where score <= 4 && time <= 20:
            return 75
        case let (score, time) where score <= 3 && time >= 22:
            return 75
        case let (score, time) where score <= 5 && time <= 22:
            return 100
        default:
            return 100
        }
    }
    
    var percentCompleted: Double {
        Double(pepPoints) / 100
    }
    
    var description: LocalizedStringKey {
        """
        Practice Evolution Projects (PEP) that are completed as part of a separately funded role (i.e. Medical Directorship, GME Directorship), will not be recognized as a means to satisfy this VC component. Departmentally pre-approved projects (Peer Remove Committee, College Mentor, New Faculty Mentor) are available. Additionally, self-selected Practice Evolution Projects must be approved in writing, in advance by a member of the Executive Leadership team. All projects must be approved no later than the end of the third quarter to allow time for them to be completed by the end of the fiscal year. Projects involving external partnerships must comply with established Prisma Health policies for external partnerships. Practice Evolution projects are just that, a project with a defined body of work.
        """
    }
    
    func loadPEPSmartGoal() {
        Logger.model.info("Loading saved from key: \(self.pepSmartGoalScoreKey)")
        self.pepSmartGoalScore = UserDefaults.standard.object(forKey: pepSmartGoalScoreKey) as? Int ?? 1
    }
    
    func loadPEPTimeCommitment() {
        Logger.model.info("Loading saved from key: \(self.pepTimeCommitmentKey)")
        self.pepTimeCommitment = UserDefaults.standard.object(forKey: pepTimeCommitmentKey) as? Int ?? 4
    }
    
    func loadAll() {
        loadPEPSmartGoal()
        loadPEPTimeCommitment()
    }
    
    func savePEPSmartGoal() {
        UserDefaults.standard.set(pepSmartGoalScore, forKey: pepSmartGoalScoreKey)
    }
    
    func savePEPTimeCommitment() {
        UserDefaults.standard.set(pepTimeCommitment, forKey: pepTimeCommitmentKey)
    }
    
    func saveAll() {
        savePEPSmartGoal()
        savePEPTimeCommitment()
    }
}
