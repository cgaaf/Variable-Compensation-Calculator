//
//  SocialProgressModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/19/23.
//

import Foundation
import SwiftUI
import OSLog

@Observable
class SocialProgressModel {
    var numberOfSPAEvents: Int {
        didSet {
            saveNumberOfSPAEvents()
        }
    }
    var averageHoursPerSPAEvent: Double {
        didSet {
            saveAverageHoursPerSPAEvent()
        }
    }
    
    var isExpanded = false
    
    private let numberOfSPAEventsKey = "NumberOfSPAEvents"
    private let averagehoursPerSPAEventKey = "AverageHoursPerSPAEvent"
    
    init(numberOfEvents: Int = 0, averageHoursPerEvent: Double = 0) {
        self.numberOfSPAEvents = numberOfEvents
        self.averageHoursPerSPAEvent = averageHoursPerEvent
    }
    
    let hoursPerEventOptions: [Double] = [0, 0.5, 0.75, 1, 2, 3, 4, 5, 6, 7, 8]
    let numberOfEventsOptions: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    var spaPoints: Int {
        switch (numberOfSPAEvents, averageHoursPerSPAEvent) {
        case let (events, averageHours) where events <= 1 || averageHours < 0.5:
            return 0
        case let (events, averageHours) where events <= 4 && averageHours <= 0.5:
            return 0
        case let (events, averageHours) where events <= 3 && averageHours <= 0.75:
            return 0
        case let (events, averageHours) where events <= 1 && averageHours <= 2:
            return 0
        case let (events, averageHours) where events <= 8 && averageHours <= 0.75:
            return 25
        case let (events, averageHours) where events <= 3 && averageHours <= 2:
            return 25
        case let (events, averageHours) where events <= 2 && averageHours <= 3:
            return 25
        case let (events, averageHours) where events <= 1 && averageHours <= 7:
            return 25
        case let (events, averageHours) where events <= 3 && averageHours <= 4:
            return 50
        case let (events, averageHours) where events == 2 && averageHours <= 6:
            return 50
        case let (events, averageHours) where events == 1 && averageHours == 8:
            return 50
        case let (events, averageHours) where events == 4 && averageHours <= 4:
            return 75
        case let (events, averageHours) where events == 3 && averageHours == 5:
            return 75
        case let (events, averageHours) where events == 2 && averageHours <= 8:
            return 75
        case let (events, averageHours) where events == 1 && averageHours >= 8:
            return 50
        case let (events, averageHours) where events == 2 && averageHours >= 8:
            return 75
        default:
            return 100
        }
    }
    
    var percentCompleted: Double {
        Double(spaPoints) / 100
    }
    
    
    var description: LocalizedStringKey {
        """
        Social Progress Activities (SPA), may be a compilation of volunteerism, that has occurred throughout the year. All SPA must be entering into the Department online platform for tracking volunteerism (currently Digital Galaxy). SPA hours logged must be entered no later than the end of the quarter in which they were completed. Examples may include, but are not limited to regularly providing staffing at the Greenville Free Clinic, CPR/emergency response training for church and/or civic groups, health education in the community for seniors/schools, taskforce development of alignment strategies with our community partners (i.e. Epic access for Community organizations), medical directorship of a charitable organization.
        """
    }
    
    func saveNumberOfSPAEvents() {
        UserDefaults.standard.set(numberOfSPAEvents, forKey: numberOfSPAEventsKey)
    }
    
    func loadNumberOfSPAEvents() {
        Logger.model.info("Loading saved from key: \(self.numberOfSPAEventsKey)")
        self.numberOfSPAEvents = UserDefaults.standard.integer(forKey: numberOfSPAEventsKey)
    }
    
    func saveAverageHoursPerSPAEvent() {
        UserDefaults.standard.set(averageHoursPerSPAEvent, forKey: averagehoursPerSPAEventKey)
    }
    
    func loadAverageHoursPerSPAEvent() {
        Logger.model.info("Loading saved from key: \(self.averagehoursPerSPAEventKey)")
        self.averageHoursPerSPAEvent = UserDefaults.standard.double(forKey: averagehoursPerSPAEventKey)
    }
    
    func loadAll() {
        loadNumberOfSPAEvents()
        loadAverageHoursPerSPAEvent()
    }
    
    func saveAll() {
        saveNumberOfSPAEvents()
        saveAverageHoursPerSPAEvent()
    }
}
