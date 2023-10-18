//
//  ContentView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = CalculatorViewModel()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Base Salary") {
                        TextField("Base Salary", value: $viewModel.baseSalary, format: .currency(code: "USD"))
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                
                LabeledContent("MGMA Percentile") {
                    TextField("MGMA Percentile", value: $viewModel.mgmaPercentile, format: .number)
                        .multilineTextAlignment(.trailing)
                }
                
                LabeledContent("WAR Activities") {
                    TextField("WAR Activities", value: $viewModel.warActivities, format: .number)
                }
                
                LabeledContent("Group Activities") {
                    TextField("WAR Activities", value: $viewModel.qualityMeasuresPoints, format: .number)
                }
                
                
            }
            .navigationTitle("Variable Compensation Estimator")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
