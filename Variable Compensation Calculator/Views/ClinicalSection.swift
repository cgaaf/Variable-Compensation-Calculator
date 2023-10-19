//
//  ClinicalSection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import SwiftUI

struct ClinicalSection: View {
    @Bindable private var model: ClinicalProductivityModel
    
    init(model: ClinicalProductivityModel) {
        self.model = model
    }
    

    
    var body: some View {
        Section {
            LabeledContent("Market Percentile") {
                TextField("Market Percentile", value: $model.rvuPercentile, format: .number, prompt: Text("Percentile"))
                    .multilineTextAlignment(.trailing)
            }
            
            VStack(alignment: .leading) {
                LabeledContent("Points Earned", value: model.clinicalPoints, format: .number)
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
            
        } header: {
            Text("Clinical Productivity")
        }
    }
}

#Preview {
    Form {
        ClinicalSection(model: .init())
    }
}
