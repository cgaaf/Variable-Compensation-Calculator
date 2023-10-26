//
//  WellnessAndResiliencySection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/19/23.
//

import SwiftUI

struct WellnessAndResiliencySection: View {
    @Bindable var activityModel: WARActivityModel
    @Bindable var vacationModel: VacationModel
    
    var body: some View {
        Section {
            LabeledContent("WAR Activities") {
                TextField("WAR Activities", value: $activityModel.warActivities, format: .number, prompt: Text("Activities"))
                    .multilineTextAlignment(.trailing)
                    .onSubmit(activityModel.saveWARActivities)
            }
            .task {
                activityModel.loadWARActivities()
            }
            
            VStack(alignment: .leading) {
                LabeledContent("Points Earned", value: activityModel.warPoints, format: .number)
                if let prompt = activityModel.prompt {
                    Text(prompt)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                if let calculation = activityModel.calculation {
                    Text(calculation)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            
            DisclosureGroup("Description") {
                Text(activityModel.description)
                    .font(.caption)
            }
            
        } header: {
            Text("Wellness And Resilience (Activities)")
        }
        
        Section {
            Toggle("Vacation Met", isOn: $vacationModel.vacationIsCompleted)
            DisclosureGroup("Description") {
                Text(vacationModel.description)
                    .font(.caption)
            }
        } header: {
            Text("Wellness And Resilience (Vacation)")
        }
    }
}

#Preview {
    Form {
        WellnessAndResiliencySection(activityModel: .init(), vacationModel: .init())
    }
}
