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
    
    init(baseSalary: Double? = nil, academicProductivityModel: AcademicProductivityModel = AcademicProductivityModel(), clinicalProductivityModel: ClinicalProductivityModel = ClinicalProductivityModel(), warActivityModel: WARActivityModel = WARActivityModel(), vacationModel: VacationModel = VacationModel(), spaModel: SocialProgressModel = SocialProgressModel(), pepModel: PracticeEvolutionModel = PracticeEvolutionModel(), qualityModel: QualityMeasuresModel = QualityMeasuresModel(), academicAdministrativeModel: AcademicAndAdministrativeModel = .init(fteAmount: 0)) {
        self.baseSalary = baseSalary
        self.academicProductivityModel = academicProductivityModel
        self.clinicalProductivityModel = clinicalProductivityModel
        self.warActivityModel = warActivityModel
        self.vacationModel = vacationModel
        self.spaModel = spaModel
        self.pepModel = pepModel
        self.qualityModel = qualityModel
        self.academicAdministrativeModel = academicAdministrativeModel
    }
    
    var academicProductivityModel: AcademicProductivityModel
    var clinicalProductivityModel: ClinicalProductivityModel
    var warActivityModel: WARActivityModel
    var vacationModel: VacationModel
    var spaModel: SocialProgressModel
    var pepModel: PracticeEvolutionModel
    var qualityModel: QualityMeasuresModel
    var academicAdministrativeModel: AcademicAndAdministrativeModel
    
    
    var administrativeAcademicFTE: Double = 0 {
        willSet {
            self.academicAdministrativeModel = .init(fteAmount: newValue)
        }
    }
    
    private var pepSpaPoints: Int {
        let total = spaModel.spaPoints + pepModel.pepPoints
        return min(100, total)
    }
    
    var academicAndAdministrativeSectionIsVisible: Bool { true }
    
    var unadjustedEarnedGeneralPoints: Int {
        let domains = [ academicProductivityModel.academicPoints, clinicalProductivityModel.clinicalPoints, warActivityModel.warPoints, vacationModel.vacationPoints, pepSpaPoints, qualityModel.qualityPoints ]
        return domains.reduce(0, +)
    }
    
    var earnedGeneralPoints: Int {
        Int(Double(unadjustedEarnedGeneralPoints) * (1 - administrativeAcademicFTE))
    }
    
    var earnedAAPoints: Int {
        academicAdministrativeModel.totalPoints
    }
    
    var totalAvailableGeneralPoints: Int {
        Int(500 * (1 - administrativeAcademicFTE))
    }
    
    var totalAvailableAAPoints: Int {
        Int(500 * administrativeAcademicFTE)
    }
    
    var totalEarnedPoints: Int {
        earnedGeneralPoints + academicAdministrativeModel.totalPoints
    }
    
    var minimumPayment: Double {
        guard let baseSalary else { return 0 }
        // Percent of base salary for calculating variable compensation contribution.
        let percentAtRisk = 0.1
        let pricePerPoint = (baseSalary * percentAtRisk) / 500
        return pricePerPoint * Double(totalEarnedPoints)
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
    
    var allCollapsed: Bool {
        [
            academicProductivityModel.isExpanded,
            clinicalProductivityModel.isExpanded,
            warActivityModel.isExpanded,
            vacationModel.isExpanded,
            spaModel.isExpanded,
            pepModel.isExpanded,
            qualityModel.isExpanded
        ].allSatisfy { $0 == false }
    }
    
    
    
    func allCollapseToggle() {
        if allCollapsed {
            expandAll()
        } else {
            collapseAll()
        }
        
        func collapseAll() {
            academicProductivityModel.isExpanded = false
            clinicalProductivityModel.isExpanded = false
            warActivityModel.isExpanded = false
            vacationModel.isExpanded = false
            spaModel.isExpanded = false
            pepModel.isExpanded = false
            qualityModel.isExpanded = false
        }
        
        func expandAll() {
            academicProductivityModel.isExpanded = true
            clinicalProductivityModel.isExpanded = true
            warActivityModel.isExpanded = true
            vacationModel.isExpanded = true
            spaModel.isExpanded = true
            pepModel.isExpanded = true
            qualityModel.isExpanded = true
        }
    }
}

