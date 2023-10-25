//
//  QualitySection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/23/23.
//

import SwiftUI

struct QualitySection: View {
    @Bindable var qualityModel: QualityMeasuresModel
    
    var body: some View {
        Section {
            LabeledContent("Acute Care Clinical Outcome Score") {
                TextField("Acute Care Clinical Outcome Score", value: $qualityModel.acuteClinicalOutcomeScore, format: .number, prompt: Text("Score"))
                    .multilineTextAlignment(.trailing)
            }
            
            VStack(alignment: .leading) {
                LabeledContent("Points Earned", value: qualityModel.qualityPoints, format: .number)
                if let prompt = qualityModel.prompt {
                    Text(prompt)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                if let calculation = qualityModel.calculation {
                    Text(calculation)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            
            DisclosureGroup("Description") {
                Text(qualityModel.description)
                    .font(.caption)
            }
            
        } header: {
            Text("Quality Measures")
        }
    }
}

#Preview {
    Form {
        QualitySection(qualityModel: QualityMeasuresModel())
    }
}
