//
//  VacationModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/19/23.
//

import Foundation
import SwiftUI

@Observable
class VacationModel {
    var vacationIsCompleted: Bool
    
    init(vacationIsCompleted: Bool = false) {
        self.vacationIsCompleted = vacationIsCompleted
    }
    
    var vacationPoints: Int {
        if vacationIsCompleted {
            return 50
        } else {
            return 0
        }
    }
    
    var description: LocalizedStringKey {
        """
        The Department’s minimum standard is a 9-day vacation block submitted via a form request in Shift Admin. Vacations that are not submitted through the forms function in ShiftAdmin (i.e., High priority requests) will not be recognized for points calculation. Any clinician meeting the minimum standard for this metric will earn 50 VC points.
        """
    }
}