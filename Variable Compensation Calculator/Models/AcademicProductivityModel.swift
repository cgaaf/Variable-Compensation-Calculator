//
//  AcademicProductivityModel.swift
//  Variable Compensation Calculator
//
//  Created by Chris Gaafary on 10/18/23.
//

import Foundation
import SwiftUI

@Observable
class AcademicProductivityModel {
    var academicRVUs: Int?
    
    init(initialAcademicRVUs: Int? = nil) {
        self.academicRVUs = initialAcademicRVUs
    }
    
    var academicPoints: Int {
        guard let academicRVUs else { return 0 } // No points when aRVU is nil
        guard academicRVUs > 20 else { return 0 } // No points until 20 aRVU threshold met
        
        let _points = (academicRVUs - 20) * 4 // Point calculation starts after 20
        guard _points <= 100 else { return 100 } // Maximum of 100 academic points
        
        return _points
    }
    
    var prompt: String? {
        guard let academicRVUs else { return nil }
        switch academicRVUs {
        case ..<20:
            return "No points earned until a minumum of 20 aRVUs met"
        case 46...:
            return "Maximum of 100 points earned after 45 aRVUs met"
        default:
            return nil
        }
    }
    
    var calculation: String? {
        guard let academicRVUs else { return nil }
        guard academicRVUs > 20 && academicRVUs <= 45 else { return nil }
        return "(\(academicRVUs) aRVUs - 20 minimum) x 4 points/aRVU"
    }
    
    var description: LocalizedStringKey {
        """
        A maximum of 100 points of the eligible Quality/VBP VC will be based upon Clinician academic productivity as represented by Academic Relative Value Units (aRVUs) on your Academic Incentive Model (AIM) Report. This component of VC is an **individual** metric.
        
        We recognize that all faculty members make valuable contributions in multiple areas that are not included in the AIM criteria. Such initiatives will be acknowledged in the annual performance reviews and/or forwarded to the Chair for consideration during promotion. Please see Academic Incentive Model (AIM) Policy for complete details of aRVU evaluation. The Department’s minimum standard of academic productivity is 20 aRVUs. Any clinician ≤ 20 aRVUs will forfeit their academic productivity VC. At 21 aRVUs, clinicians will earn **4 VC points per aRVU** to 45 aRVUs (a maximum of 100 points). Academic productivity requirements will be prorated to total FTE.
        """
    }
}
