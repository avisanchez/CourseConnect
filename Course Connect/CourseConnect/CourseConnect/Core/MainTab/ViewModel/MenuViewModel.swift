//
//  MenuViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/28/22.
//

import Foundation
import SwiftUI


enum MenuViewModel: Int, CaseIterable {
    case profile
    case learnMore
    case logout
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .learnMore: return "Learn more"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .learnMore: return "info.circle"
        case .logout: return "arrow.left.square"
        }
    }
    
}
