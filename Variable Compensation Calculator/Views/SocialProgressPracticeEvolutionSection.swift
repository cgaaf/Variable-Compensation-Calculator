//
//  SocialProgressPracticeEvolutionSection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/20/23.
//

import SwiftUI

struct SocialProgressPracticeEvolutionSection: View {
    @Bindable var spaModel: SocialProgressModel
    @Bindable var pepModel: PracticeEvolutionModel
    
    var total: Int {
        min(100, spaModel.spaPoints + pepModel.pepPoints)
    }
    
    var body: some View {
        Section {
            LabeledContent("# of events") {
                Picker("", selection: $spaModel.numberOfEvents) {
                    ForEach(spaModel.numberOfEventsOptions, id: \.self) { number in
                        Text(number, format: .number)
                            .tag(number)
                    }
                }
            }
            
            LabeledContent("Average hours per event") {
                Picker("", selection: $spaModel.averageHoursPerEvent) {
                    ForEach(spaModel.hoursPerEventOptions, id: \.self) { number in
                        Text(number, format: .number)
                            .tag(number)
                    }
                }
            }
            
            LabeledContent("Points Earned", value: spaModel.spaPoints, format: .number)
        } header: {
            Text("Social Progress Activities")
        }
        
        Section {
            LabeledContent("Smart goal score") {
                Picker("", selection: $pepModel.smartGoalScore) {
                    ForEach(pepModel.smartGoalOptions, id: \.self) { number in
                        Text(number, format: .number)
                            .tag(number)
                    }
                }
            }
            
            LabeledContent("Estimated time commitment") {
                Picker("", selection: $pepModel.timeCommitment) {
                    ForEach(pepModel.timeCommitmentOptions, id: \.self) { number in
                        Text(number, format: .number)
                            .tag(number)
                    }
                }
            }
            
            LabeledContent("Points Earned", value: pepModel.pepPoints, format: .number)
        } header: {
            Text("Practice Evolution Project")
        }
        
        Section {
            LabeledContent("Points Earned", value: total, format: .number)
        } header: {
            Text("Total PEP / SPA")
        }
    }
}

#Preview {
    Form {
        SocialProgressPracticeEvolutionSection(spaModel: SocialProgressModel(), pepModel: PracticeEvolutionModel())
    }
}