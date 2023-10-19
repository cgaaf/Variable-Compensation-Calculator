//
//  CalculatorModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import Foundation

@Observable
class CalculatorModel {
    var academicProductivityModel = AcademicProductivityModel()
    var clinicalProductivityModel = ClinicalProductivityModel()
    var warActivityModel = WARActivityModel()
    var vacationModel = VacationModel()
    
    var totalPoints: Int {
        let domains = [ academicProductivityModel.academicPoints, clinicalProductivityModel.clinicalPoints, warActivityModel.warPoints, vacationModel.vacationPoints ]
        return domains.reduce(0, +)
    }
}
