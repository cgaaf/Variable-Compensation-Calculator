//
//  SocialProgressPracticeEvolutionSection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/20/23.
//

import SwiftUI

struct SocialProgressPracticeEvolutionSection: View {
    let spaModel: SocialProgressModel
    let pepModel: PracticeEvolutionModel
    
    @State var isExpanded = true
    
    var total: Int {
        min(100, spaModel.spaPoints + pepModel.pepPoints)
    }
    
    var percentCompleted: Double {
        Double(total) / 100
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            LabeledContent("Total Points Earned", value: total, format: .number)
            
            SocialProgressSection(model: spaModel)
                .gaugeStyle(.accessoryLinearCapacity)
            
            PracticeEvolutionSection(model: pepModel)
                .gaugeStyle(.accessoryLinearCapacity)
            
        } label: {
            SectionLabelView(title: "PEP & SPA", gaugeValue: percentCompleted)
        }
        
    }
    
    struct SocialProgressSection: View {
        @Bindable var model: SocialProgressModel
        
        var body: some View {
            DisclosureGroup(isExpanded: $model.isExpanded) {
                LabeledContent("# of events") {
                    Picker("", selection: $model.numberOfSPAEvents) {
                        ForEach(model.numberOfEventsOptions, id: \.self) { number in
                            Text(number, format: .number)
                                .tag(number)
                        }
                    }
                }
                
                LabeledContent("Average hours per event") {
                    Picker("", selection: $model.averageHoursPerSPAEvent) {
                        ForEach(model.hoursPerEventOptions, id: \.self) { number in
                            Text(number, format: .number)
                                .tag(number)
                        }
                    }
                }
                
                LabeledContent("Points Earned", value: model.spaPoints, format: .number)
                
                DisclosureGroup("Description") {
                    Text(model.description)
                        .font(.caption)
                }
                
            } label: {
                SectionLabelView(title: "Social Progress Activities", gaugeValue: model.percentCompleted)
            }
        }
    }
    
    struct PracticeEvolutionSection: View {
        @Bindable var model: PracticeEvolutionModel
        
        var body: some View {
            DisclosureGroup(isExpanded: $model.isExpanded) {
                LabeledContent("Smart goal score") {
                    Picker("", selection: $model.pepSmartGoalScore) {
                        ForEach(model.smartGoalOptions, id: \.self) { number in
                            Text(number, format: .number)
                                .tag(number)
                        }
                    }
                }
                
                LabeledContent("Estimated time commitment") {
                    Picker("", selection: $model.pepTimeCommitment) {
                        ForEach(model.timeCommitmentOptions, id: \.self) { number in
                            Text(number, format: .number)
                                .tag(number)
                        }
                    }
                }
                
                LabeledContent("Points Earned", value: model.pepPoints, format: .number)
                
                DisclosureGroup("Description") {
                    Text(model.description)
                        .font(.caption)
                }
                
            } label: {
                SectionLabelView(title: "Practice Evolution Project", gaugeValue: model.percentCompleted)
            }
        }
    }
}

#Preview {
    Form {
        SocialProgressPracticeEvolutionSection(spaModel: SocialProgressModel(), pepModel: PracticeEvolutionModel())
    }
}
