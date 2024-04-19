//
//  SectionIsExpanded+EnvironmentValue.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 4/19/24.
//

import Foundation
import SwiftUI

private struct SectionIsExpandedEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var sectionIsExpanded: Bool {
        get { self[SectionIsExpandedEnvironmentKey.self] }
        set { self[SectionIsExpandedEnvironmentKey.self] = newValue }
    }
}
