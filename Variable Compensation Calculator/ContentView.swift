//
//  ContentView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/2/23.
//

import SwiftUI
import OSLog

struct ContentView: View {
    @State var position: Int?
    @Namespace var topID
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                VCFormView()
                    .navigationTitle("Variable Compensation Estimator")
                    .toolbarTitleDisplayMode(.inline)
                    .scrollPosition(id: $position)
            }
            .onChange(of: position, initial: true, { oldValue, newValue in
                if let position {
                    print(position)
                } else {
                    print("Position is nil")
                }
            })
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
