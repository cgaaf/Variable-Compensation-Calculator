//
//  AASection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 11/30/23.
//

import SwiftUI

struct AASection: View {
    @Bindable var model: AcademicAndAdministrativeModel
    
    var body: some View {
        DisclosureGroup {
            LabeledContent("Smart Goals Achieved") {
                TextField("Smart Goals", value: $model.smartGoalsAchieved, format: .number.precision(.fractionLength(0)))
                    .multilineTextAlignment(.trailing)
                    .fixedSize()
            }
            
            LabeledContent("Total Smart Goals Available") {
                TextField("Enter Total Available Smart Goals", value: $model.smartGoalsAvailable, format: .number.precision(.fractionLength(0)))
                    .multilineTextAlignment(.trailing)
            }
            
            LabeledContent("FTE Amount", value: model.fteAmount, format: .number)
            
            LabeledContent("Points Earned", value: model.totalPoints, format: .number)
            
            
        } label: {
            SectionLabelView(title: "Academic & Administrative", gaugeValue: model.percentCompleted)
        }
    }
}

#Preview {
    Form {
        AASection(model: .init(fteAmount: 0.05))
    }
}
