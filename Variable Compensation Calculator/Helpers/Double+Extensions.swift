//
//  Double+Extensions.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 4/23/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
