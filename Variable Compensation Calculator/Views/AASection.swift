//
//  AASection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 11/30/23.
//

import SwiftUI

struct AASection: View {
    @State var smartGoalsAchieved: Int = 0
    @State var smartGoalsAvailable: Int = 0
    
    var body: some View {
        Section {
            LabeledContent("Smart Goals Achieved") {
                TextField("Smart Goals", value: $smartGoalsAchieved, format: .number.precision(.fractionLength(0)))
                    .multilineTextAlignment(.trailing)
                    .fixedSize()
            }
            
            LabeledContent("Total Smart Goals Available") {
                TextField("Enter Total Available Smart Goals", value: $smartGoalsAchieved, format: .number.precision(.fractionLength(0)))
                    .multilineTextAlignment(.trailing)
            }
        } header: {
            Text("Academic & Administrative")
        }
    }
}

#Preview {
    Form {
        AASection()
    }
}
