//
//  ContentView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/2/23.
//

import SwiftUI
import OSLog

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VCFormView()
                .navigationTitle("Variable Compensation Estimator")
                .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Dismiss Keyboard") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
