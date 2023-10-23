//
//  ContentView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var baseSalary = 0
    @State var calculatorModel = CalculatorModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Base Salary") {
                        TextField("Base Salary", value: $baseSalary, format: .currency(code: "USD"))
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                ClinicalSection(model: calculatorModel.clinicalProductivityModel)
                AcademicSection(model: calculatorModel.academicProductivityModel)
                WellnessAndResiliencySection(activityModel: calculatorModel.warActivityModel, vacationModel: calculatorModel.vacationModel)
                SocialProgressPracticeEvolutionSection(spaModel: calculatorModel.spaModel)
                
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
