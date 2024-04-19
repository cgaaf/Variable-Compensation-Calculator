//
//  QualitySection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/23/23.
//

import SwiftUI

struct QualitySection: View {
    @Bindable var model: QualityMeasuresModel
    
    @State var isExpanded = true
    
    var body: some View {
        Section {
            DisclosureGroup(isExpanded: $isExpanded) {
                LabeledContent("Acute Care Clinical Outcome Score") {
                    TextField("Acute Care Clinical Outcome Score", value: $model.acuteClinicalOutcomeScore, format: .number, prompt: Text("Score"))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    LabeledContent("Points Earned", value: model.qualityPoints, format: .number)
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
                SectionLabelView(title: "Quality Measures", gaugeValue: model.percentCompleted)
            }
        }
    }
}

#Preview {
    Form {
        QualitySection(model: QualityMeasuresModel())
    }
}
