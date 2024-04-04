//
//  ClinicalSection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import SwiftUI

struct ClinicalSection: View {
    @Bindable private var model: ClinicalProductivityModel
    @FocusState private var isFocused: Bool
    @State private var isExpanded = true
    
    init(model: ClinicalProductivityModel) {
        self.model = model
    }
    

    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            LabeledContent("Market Percentile") {
                TextField("Market Percentile", value: $model.rvuPercentile, format: .number, prompt: Text("Percentile"))
                    .multilineTextAlignment(.trailing)
                    .onSubmit(model.saveRVUPercentile)
                    .focused($isFocused)
                    .keyboardType(.numberPad)
                    .scrollDismissesKeyboard(.immediately)
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
            
            Gauge(value: 0.8) {
                Text("Progress")
            }
            .gaugeStyle(CustomGaugeStyle())
            .tint(Gradient(colors: [.purple, .cyan, .green]))
            
            DisclosureGroup("Description") {
                Text(model.description)
                    .font(.caption)
            }
            
        } label: {
            VStack(alignment: .leading) {
                Text("Clinical Productivity")
                    .font(.headline)
                Gauge(value: 0.5) {}
                    .tint(Gradient(colors: [.purple, .cyan, .green]))
            }
            
        }
    }
}

#Preview {
    Form {
        ClinicalSection(model: .init())
    }
}

struct CustomGaugeStyle: GaugeStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            
            GeometryReader { proxy in
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundStyle(.gray)
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundStyle(.tint)
                }
                
            }
            
        }
    }
}
