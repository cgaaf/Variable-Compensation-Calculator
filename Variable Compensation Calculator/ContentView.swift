//
//  ContentView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var calculatorModel = CalculatorModel()
    @State var position: Int?
    @Namespace var topID
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                Form {
                    Section {
                        LabeledContent("Base Salary") {
                            TextField("Base Salary", value: $calculatorModel.baseSalary, format: .currency(code: "USD"))
                                .multilineTextAlignment(.trailing)
                                .onSubmit(of: /*@START_MENU_TOKEN@*/.text/*@END_MENU_TOKEN@*/, calculatorModel.saveBaseSalary)
                                
                        }
                        LabeledContent("Total VC Points", value: calculatorModel.totalPoints, format: .number)
                        LabeledContent("Minimum VC Payment", value: calculatorModel.minimumPayment, format: .currency(code: "USD"))
                    }
                    .id(topID)
                    
                    ClinicalSection(model: calculatorModel.clinicalProductivityModel)
                    AcademicSection(model: calculatorModel.academicProductivityModel)
                    WellnessAndResiliencySection(activityModel: calculatorModel.warActivityModel, vacationModel: calculatorModel.vacationModel)
                    SocialProgressPracticeEvolutionSection(spaModel: calculatorModel.spaModel, pepModel: calculatorModel.pepModel)
                    QualitySection(qualityModel: calculatorModel.qualityModel)
                    Button("Scroll to top") {
                        withAnimation {
                            proxy.scrollTo(topID, anchor: .top)
                        }
                    }
                }
                .navigationTitle("Variable Compensation Estimator")
                .toolbarTitleDisplayMode(.inline)
                .formStyle(.grouped)
                .scrollPosition(id: $position)
            }
        }
    }
}

#Preview {
    ContentView()
}
