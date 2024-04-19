//
//  VCFormView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 11/7/23.
//

import SwiftUI

struct VCFormView: View {
    @State var calculatorModel = CalculatorModel()
    @Namespace var topID
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                Section {
                    LabeledContent("Base Salary") {
                        TextField("Base Salary", value: $calculatorModel.baseSalary, format: .currency(code: "USD"))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        
                    }
                    LabeledContent("Academic & Administrative FTE") {
                        TextField("Buydown", value: .constant(0), format: .number.precision(.fractionLength(0...2)))
                            .multilineTextAlignment(.trailing)
                        
                        
                    }
                    LabeledContent("Total VC Points", value: calculatorModel.totalPoints, format: .number)
                    LabeledContent("Minimum VC Payment", value: calculatorModel.minimumPayment, format: .currency(code: "USD"))
                }
                .id(topID)
                
                ClinicalSection(model: calculatorModel.clinicalProductivityModel)
                AcademicSection(model: calculatorModel.academicProductivityModel)
                WellnessAndResiliencySection(activityModel: calculatorModel.warActivityModel, vacationModel: calculatorModel.vacationModel)
                SocialProgressPracticeEvolutionSection(spaModel: calculatorModel.spaModel, pepModel: calculatorModel.pepModel)
                QualitySection(model: calculatorModel.qualityModel)
                
                Section {
                    Button {
                        withAnimation {
                            proxy.scrollTo(topID, anchor: .top)
                        }
                    } label: {
                        LabeledContent {
                            Image(systemName: "arrow.up")
                                .foregroundStyle(.blue)
                        } label: {
                            Text("Scroll to top")
                        }
                        
                    }
                }
                
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(.compact)
        }
        .task {
            calculatorModel.loadAll()
        }
    }
}

#Preview {
    VCFormView()
}
