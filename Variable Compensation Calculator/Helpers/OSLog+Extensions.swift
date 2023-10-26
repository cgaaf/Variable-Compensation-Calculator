//
//  OSLog+Extensions.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/26/23.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let model = Logger(subsystem: subsystem, category: "model")
}
