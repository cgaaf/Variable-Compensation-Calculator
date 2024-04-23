//
//  AcademicAndAdministrativeModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 04/23/2024.
//

import Foundation
import SwiftUI
import OSLog

@Observable
class AcademicAndAdministrativeModel {
    var fteAmount: Double
    
    var smartGoalsAchieved: Int? {
        didSet {
            saveSmartGoalsAchieved()
        }
    }
    
    var smartGoalsAvailable: Int? {
        didSet {
            saveSmartGoalsAvailable()
        }
    }
    
    private let smartGoalsAchievedKey = "SmartGoalsAchieved"
    private let smartGoalsAvailableKey = "SmartGoalsAvailable"
    
    var isExpanded = false
    
    init(fteAmount: Double, smartGoalsAchieved: Int? = nil, smartGoalsAvailable: Int? = nil) {
        self.fteAmount = fteAmount
        self.smartGoalsAchieved = smartGoalsAchieved
        self.smartGoalsAvailable = smartGoalsAvailable
        
        loadSmartGoalsAchieved()
        loadSmartGoalsAvailable()
    }
    
    //    var academicAdministrativePoints: Int {
    //        // TODO: Implement logic
    //    }
    
    var percentCompleted: Double {
        guard let smartGoalsAchieved, let smartGoalsAvailable else {
            return 0
        }
        
        return Double(smartGoalsAchieved) / Double(smartGoalsAvailable)
    }
    
    var totalPoints: Int {
        Int(fteAmount * 500 * percentCompleted)
    }
    
    
//    var calculation: String? {
//        // TODO: Implement
//    }
    
    func saveSmartGoalsAchieved() {
        if let smartGoalsAchieved {
            UserDefaults.standard.setValue(smartGoalsAchieved, forKey: smartGoalsAchievedKey)
        } else {
            Logger.model.info("smartGoalsAchieved is currently nil. Save to UserDefaults only when a value is present")
        }
    }
    
    func saveSmartGoalsAvailable() {
        if let smartGoalsAvailable {
            UserDefaults.standard.setValue(smartGoalsAvailable, forKey: smartGoalsAvailableKey)
        } else {
            Logger.model.info("smartGoalsAvailable is currently nil. Save to UserDefaults only when a value is present")
        }
    }
    
    func loadSmartGoalsAchieved() {
        Logger.model.info("Loading saved from key: \(self.smartGoalsAchievedKey)")
        if let goalsAchieved = UserDefaults.standard.value(forKey: smartGoalsAchievedKey) as? Int {
            self.smartGoalsAchieved = goalsAchieved
        }
        
//        self.smartGoalsAchieved = UserDefaults.standard.object(forKey: smartGoalsAchievedKey) as? Int
    }
    
    func loadSmartGoalsAvailable() {
        Logger.model.info("Loading saved from key: \(self.smartGoalsAvailableKey)")
//        self.smartGoalsAvailable = UserDefaults.standard.object(forKey: smartGoalsAvailableKey) as? Int
        
        if let goalsAvailable = UserDefaults.standard.object(forKey: smartGoalsAvailableKey) as? Int {
            self.smartGoalsAvailable = goalsAvailable
        }
    }
}
