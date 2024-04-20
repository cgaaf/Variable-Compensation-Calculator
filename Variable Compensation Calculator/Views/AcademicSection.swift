//
//  AcademicSection.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import SwiftUI

struct AcademicSection: View {
    @Bindable private var model: AcademicProductivityModel
    
    init(model: AcademicProductivityModel) {
        self.model = model
    }
    
    var body: some View {
        Section {
            DisclosureGroup(isExpanded: $model.isExpanded) {
                LabeledContent("Academic RVUs") {
                    TextField("Academic RVUs", value: $model.academicRVUs, format: .number, prompt: Text("aRVUs"))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading) {
                    LabeledContent("Points Earned", value: model.academicPoints, format: .number)
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
                SectionLabelView(title: "Academic Productivity", gaugeValue: model.percentCompleted)
            }
        }
    }
}

#Preview {
    Form {
        AcademicSection(model: .init())
        AcademicSection(model: .init(initialAcademicRVUs: 25))
        AcademicSection(model: .init(initialAcademicRVUs: 46))
        AcademicSection(model: .init(initialAcademicRVUs: 0))
    }
}
