//
//  CalculatorViewModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/17/23.
//

import Foundation

@Observable
class CalculatorViewModel {
    var baseSalary: Double
    
    var academicRVUs: Int
    var mgmaPercentile: Int
    var warActivities: Int
    var socialProgressAndPracticeEvolutionPoints: Int
    var qualityMeasuresPoints: Int
    var vacationMet: Bool
    
    var warPoints: Int {
        guard warActivities > 50 else { return 0 } // No points until 50 activity threshold met
        
        let _points = (warActivities - 50) * 2 // Point calculation starts after 50
        guard _points <= 100 else { return 100 } // Maximum of 100 war points
        
        return _points
    }
    
    var academicPoints: Int {
        guard academicRVUs > 20 else { return 0 } // No points until 20 aRVU threshold met
        
        let _points = (academicRVUs - 20) * 4 // Point calculation starts after 20
        guard _points <= 100 else { return 100 } // Maximum of 100 academic points
        
        return _points
    }
    
    var clinicalPoints: Int {
        guard mgmaPercentile > 35 else { return 0 } // Must meet minimum 35th percentile
        
        let _points = (mgmaPercentile - 35) * 4 // Point accumulation starts after 35
        guard _points <= 100 else { return 100 } // Maximum of 100 clinical points
        
        return _points
    }
    
    var vacationPoints: Int  {
        guard vacationMet else { return 0 }
        return 50
    }
    
    var spaPepPoints: Int {
        guard socialProgressAndPracticeEvolutionPoints <= 100 else { return 100 } // Maxmimum 100 points
        guard socialProgressAndPracticeEvolutionPoints > 0 else { return 0 } // No negative numbers allowed
        return socialProgressAndPracticeEvolutionPoints
    }
    
    var qualityPoints: Int {
        guard qualityMeasuresPoints <= 50 else { return 50 } // Maximum 50 points
        return qualityMeasuresPoints
    }
    
    var totalPoints: Int {
        warPoints + academicPoints + clinicalPoints + spaPepPoints + vacationPoints + qualityPoints
    }
    
    var inputSalary: Double {
        guard baseSalary > 0 else { return 0 } // Salary must be a positive number
        return baseSalary
    }
    
    var maxVCCompensation: Double {
        inputSalary * 0.15
    }
    
    init(baseSalary: Double = 0, academicProductivityPoints: Int = 0, clinicalProductivityPoints: Int = 0, wellnessAndResiliencyPoints: Int = 0, socialProgressAndPracticeEvolutionPoints: Int = 0, qualityMeasuresPoints: Int = 0, vacationMet: Bool = false) {
        self.baseSalary = baseSalary
        self.academicRVUs = academicProductivityPoints
        self.mgmaPercentile = clinicalProductivityPoints
        self.warActivities = wellnessAndResiliencyPoints
        self.socialProgressAndPracticeEvolutionPoints = socialProgressAndPracticeEvolutionPoints
        self.qualityMeasuresPoints = qualityMeasuresPoints
        self.vacationMet = vacationMet
    }
    
    func calculateVariableCompensation() -> Double {
        let vcContribution: Double = inputSalary * 0.1
        let percentEarned: Double = Double(totalPoints) / 500
        return vcContribution * percentEarned
    }
}
