//
//  ContentView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var calculatorModel = CalculatorModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Base Salary") {
                        TextField("Base Salary", value: $calculatorModel.baseSalary, format: .currency(code: "USD"))
                            .multilineTextAlignment(.trailing)
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
            .navigationTitle("Variable Compensation Estimator")
            .toolbarTitleDisplayMode(.inline)
            .formStyle(.grouped)
        }
    }
}

#Preview {
    ContentView()
}
