//
//  SectionLabelView.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 4/19/24.
//

import SwiftUI

struct SectionLabelView: View {
    let title: String
    var gaugeValue: Double
    let font: Font
    
    init(title: String, gaugeValue: Double, font: Font = .headline) {
        self.title = title
        self.font = font
        self.gaugeValue = gaugeValue
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(font)
            Gauge(value: gaugeValue) {}
                .tint(Gradient(colors: [.purple, .cyan, .green]))
                .animation(.spring, value: gaugeValue)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    List {
        SectionLabelView(title: "Label Title", gaugeValue: 0.5)
    }
}
