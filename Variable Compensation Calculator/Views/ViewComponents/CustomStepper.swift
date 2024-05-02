//
//  CustomStepper.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 4/20/24.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Double
    let step: Double = 0.05
    let range: ClosedRange<Double> = 0 ... 0.75
    
    var body: some View {
        LabeledContent("A&A FTE") {
            HStack {
                StepperButton(title: "Minus", systemImage: "minus", action: onDecrement)
                Text(value, format: .number)
                    .frame(width: 40)
                    .animation(.none, value: value)
                StepperButton(title: "Plus", systemImage: "plus", action: onIncrement)
                
            }
            .labelStyle(.iconOnly)
            .background(.background, in: .rect)
        }
    }
    
    func onIncrement() {
        print("Tapped")
        guard value + step <= range.upperBound else {
            return
        }
        withAnimation {
            let valueToUpdate = (value + step).rounded(toPlaces: 2)
            value = valueToUpdate
        }
    }
    
    func onDecrement() {
        guard value - step >= range.lowerBound else {
            return
        }
        withAnimation {
            let valueToUpdate = (value - step).rounded(toPlaces: 2)
            value = valueToUpdate
        }
    }
    
    struct StepperButton: View {
        let title: String
        let systemImage: String
        let action: () -> Void
        
        var body: some View {
            Label(title, systemImage: systemImage)
                .labelStyle(.iconOnly)
                .frame(width: 35, height: 30)
                .contentShape(.rect(cornerRadius: 5))
                .background(Color(uiColor: .systemGroupedBackground), in: .rect(cornerRadius: 5))
                .onTapGesture(perform: action)
        }
    }
}

#Preview {
    @State var value = 1.0
    return List {
        CustomStepper(value: $value)
    }
}
