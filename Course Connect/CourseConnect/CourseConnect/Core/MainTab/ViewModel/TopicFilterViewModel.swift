//
//  TopicFilterViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import Foundation

enum TopicFilterViewModel: Int, CaseIterable {
    case recent
    case popular
    case discover
    
    var title: String {
        switch self {
        case .recent: return "Recent"
        case .popular: return "Popular"
        case .discover: return "Discover"
        }
    }
}
