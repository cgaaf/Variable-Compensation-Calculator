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
                    
                   
                    CustomStepper(value: $calculatorModel.administrativeAcademicFTE)
                        .padding(.trailing, -4)
                    
                    DisclosureGroup {
                        LabeledContent("General Points Earned", value: calculatorModel.earnedGeneralPoints, format: .number)
                        LabeledContent("General Points Available", value: calculatorModel.totalAvailableGeneralPoints, format: .number)
                        
                        LabeledContent("AA Points Earned", value: calculatorModel.earnedAAPoints, format: .number)
                        LabeledContent("AA Points Available", value: calculatorModel.totalAvailableAAPoints, format: .number)
                        
                        
                    } label: {
                        LabeledContent("Total VC Points", value: calculatorModel.totalEarnedPoints, format: .number)
                            .animation(.none, value: calculatorModel.totalEarnedPoints)
                    }
                    
                    LabeledContent("Minimum VC Payment", value: calculatorModel.minimumPayment, format: .currency(code: "USD"))
                        .animation(.none, value: calculatorModel.minimumPayment)
                }
                .id(topID)
                .onChange(of: calculatorModel.administrativeAcademicFTE) { oldValue, newValue in
                    print(newValue)
                }
                
                if calculatorModel.administrativeAcademicFTE > 0 {
                    AASection(model: calculatorModel.academicAdministrativeModel)
                }
                
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
        .toolbar {
            Button("Collapse", systemImage: "square.stack.3d.up") {
                withAnimation {
                    calculatorModel.allCollapseToggle()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        VCFormView()
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
    }
}
