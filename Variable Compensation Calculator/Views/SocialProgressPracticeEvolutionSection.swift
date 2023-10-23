//
//  SocialProgressPracticeEvolutionSection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/20/23.
//

import SwiftUI

struct SocialProgressPracticeEvolutionSection: View {
    @Bindable var spaModel: SocialProgressModel
    
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
    }
}

#Preview {
    Form {
        SocialProgressPracticeEvolutionSection(spaModel: SocialProgressModel())
    }
}
