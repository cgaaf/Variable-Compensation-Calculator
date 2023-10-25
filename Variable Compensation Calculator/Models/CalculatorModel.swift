//
//  CalculatorModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import Foundation

@Observable
class CalculatorModel {
    var baseSalary: Double = 0
    
    var academicProductivityModel = AcademicProductivityModel()
    var clinicalProductivityModel = ClinicalProductivityModel()
    var warActivityModel = WARActivityModel()
    var vacationModel = VacationModel()
    var spaModel = SocialProgressModel()
    var pepModel = PracticeEvolutionModel()
    var qualityModel = QualityMeasuresModel()
    
    var pepSpaPoints: Int {
        let total = spaModel.spaPoints + pepModel.pepPoints
        return min(100, total)
    }
    
    var totalPoints: Int {
        let domains = [ academicProductivityModel.academicPoints, clinicalProductivityModel.clinicalPoints, warActivityModel.warPoints, vacationModel.vacationPoints, pepSpaPoints, qualityModel.qualityPoints ]
        return domains.reduce(0, +)
    }
    
    var minimumPayment: Double {
        let pricePerPoint = (baseSalary * 0.1) / 500
        return pricePerPoint * Double(totalPoints)
    }
}
