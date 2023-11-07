//
//  VCFormView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 11/7/23.
//

import SwiftUI

struct VCFormView: View {
    @State var calculatorModel = CalculatorModel()
    
    var body: some View {
        Form {
            Section {
                LabeledContent("Base Salary") {
                    TextField("Base Salary", value: $calculatorModel.baseSalary, format: .currency(code: "USD"))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        
                }
                LabeledContent("Total VC Points", value: calculatorModel.totalPoints, format: .number)
                LabeledContent("Minimum VC Payment", value: calculatorModel.minimumPayment, format: .currency(code: "USD"))
            }
            
            ClinicalSection(model: calculatorModel.clinicalProductivityModel)
            AcademicSection(model: calculatorModel.academicProductivityModel)
            WellnessAndResiliencySection(activityModel: calculatorModel.warActivityModel, vacationModel: calculatorModel.vacationModel)
            SocialProgressPracticeEvolutionSection(spaModel: calculatorModel.spaModel, pepModel: calculatorModel.pepModel)
            QualitySection(qualityModel: calculatorModel.qualityModel)
        }
        .scrollTargetLayout()
        .formStyle(.grouped)
        .task {
            calculatorModel.loadAll()
        }
    }
}

#Preview {
    VCFormView()
}
