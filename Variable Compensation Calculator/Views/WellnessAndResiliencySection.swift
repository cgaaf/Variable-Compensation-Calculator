//
//  WellnessAndResiliencySection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/19/23.
//

import SwiftUI

struct WellnessAndResiliencySection: View {
    let activityModel: WARActivityModel
    let vacationModel: VacationModel
    
    @State var isExpanded = true
    
    var percentCompleted: Double {
        (Double(activityModel.warPoints) + Double(vacationModel.vacationPoints)) / 150
    }
    
    var body: some View {
        Section {
            DisclosureGroup(isExpanded: $isExpanded) {
                ActivitySection(model: activityModel)
                VacationSection(model: vacationModel)
            } label: {
                SectionLabelView(title: "Wellness and Resilience", gaugeValue: percentCompleted)
            }
        }

    }
    
    struct ActivitySection: View {
        @Bindable var model: WARActivityModel
        
        var body: some View {
            DisclosureGroup(isExpanded: $model.isExpanded) {
                LabeledContent("WAR Activities") {
                    TextField("WAR Activities", value: $model.warActivities, format: .number, prompt: Text("Activities"))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    LabeledContent("Points Earned", value: model.warPoints, format: .number)
                    if let prompt = model.prompt {
                        Text(prompt)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                    
                    if let calculation = model.calculation {
                        Text(calculation)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                
                DisclosureGroup("Description") {
                    Text(model.description)
                        .font(.caption)
                }
                
            } label: {
                SectionLabelView(title: "Activities", gaugeValue: model.percentCompleted)
                    .gaugeStyle(.accessoryLinearCapacity)
            }
        }
    }
    
    struct VacationSection: View {
        @Bindable var model: VacationModel
        
        var body: some View {
            DisclosureGroup(isExpanded: $model.isExpanded) {
                Toggle("Vacation Met", isOn: $model.vacationIsCompleted)
                DisclosureGroup("Description") {
                    Text(model.description)
                        .font(.caption)
                }
            } label: {
                SectionLabelView(title: "Vacation", gaugeValue: model.percentCompleted)
                    .gaugeStyle(.accessoryLinearCapacity)
            }
        }
    }
}

#Preview {
    List {
        WellnessAndResiliencySection(activityModel: .init(), vacationModel: .init())
    }
    .listStyle(.inset)
}
