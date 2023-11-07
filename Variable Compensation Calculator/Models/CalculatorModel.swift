//
//  CalculatorModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import Foundation
import OSLog

@Observable
class CalculatorModel {
    var baseSalary: Double? {
        didSet {
            saveBaseSalary()
        }
    }
    private let baseSalaryKey = "BaseSalary"
    
    init(baseSalary: Double? = nil, academicProductivityModel: AcademicProductivityModel = AcademicProductivityModel(), clinicalProductivityModel: ClinicalProductivityModel = ClinicalProductivityModel(), warActivityModel: WARActivityModel = WARActivityModel(), vacationModel: VacationModel = VacationModel(), spaModel: SocialProgressModel = SocialProgressModel(), pepModel: PracticeEvolutionModel = PracticeEvolutionModel(), qualityModel: QualityMeasuresModel = QualityMeasuresModel()) {
        self.baseSalary = baseSalary
        self.academicProductivityModel = academicProductivityModel
        self.clinicalProductivityModel = clinicalProductivityModel
        self.warActivityModel = warActivityModel
        self.vacationModel = vacationModel
        self.spaModel = spaModel
        self.pepModel = pepModel
        self.qualityModel = qualityModel
    }
    
    var academicProductivityModel: AcademicProductivityModel
    var clinicalProductivityModel: ClinicalProductivityModel
    var warActivityModel: WARActivityModel
    var vacationModel: VacationModel
    var spaModel: SocialProgressModel
    var pepModel: PracticeEvolutionModel
    var qualityModel: QualityMeasuresModel
    
    var pepSpaPoints: Int {
        let total = spaModel.spaPoints + pepModel.pepPoints
        return min(100, total)
    }
    
    var totalPoints: Int {
        let domains = [ academicProductivityModel.academicPoints, clinicalProductivityModel.clinicalPoints, warActivityModel.warPoints, vacationModel.vacationPoints, pepSpaPoints, qualityModel.qualityPoints ]
        return domains.reduce(0, +)
    }
    
    var minimumPayment: Double {
        guard let baseSalary else { return 0 }
        let pricePerPoint = (baseSalary * 0.1) / 500
        return pricePerPoint * Double(totalPoints)
    }
    
    func saveBaseSalary() {
        if let baseSalary {
            UserDefaults.standard.set(baseSalary, forKey: baseSalaryKey)
        }
    }
    
    func loadBaseSalary() {
        self.baseSalary = UserDefaults.standard.object(forKey: baseSalaryKey) as? Double
    }
    
    func saveAll() {
        saveBaseSalary()
        academicProductivityModel.saveAcademicRVUs()
        clinicalProductivityModel.saveRVUPercentile()
        warActivityModel.saveWARActivities()
        vacationModel.saveVacationIsCompleted()
        spaModel.saveAll()
        pepModel.saveAll()
        qualityModel.saveAcuteClinicalOutcomeScore()
    }
    
    func loadAll() {
        loadBaseSalary()
        academicProductivityModel.loadAcademicRVUs()
        clinicalProductivityModel.loadRVUPercentile()
        warActivityModel.loadWARActivities()
        vacationModel.loadVacationIsCompleted()
        spaModel.loadAll()
        pepModel.loadAll()
        qualityModel.loadAcuteClinicalOutcomeScore()
    }
}
