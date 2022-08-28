//
//  Extensions.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/20/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

// app color extensions
struct ColorTheme {
    let blue = Color(red: 12/255, green: 71/255, blue: 231/255)
    let blueDark = Color(red: 11/255, green: 32/255, blue: 78/255)
    let white = Color(red: 255/255, green: 255/255, blue: 255/255)
    let whiteOff = Color(red: 243/255, green: 246/255, blue: 250/255)
    let black = Color(red: 0/255, green: 0/255, blue: 0/255)
    let gray = Color(red: 195/255, green: 195/255, blue: 195/255)
    let green = Color(red: 81/255, green: 201/255, blue: 201/255)
    let red = Color(red: 196/255, green: 81/255, blue: 104/255)
    
    
    let purple = Color(red: 118/255, green: 23/255, blue: 153/255)
    let blue2 = Color(red: 118/255, green: 23/255, blue: 153/255)
    let blue3 = Color(red: 71/255, green: 102/255, blue: 149/255)
    let red2 = Color(red: 196/255, green: 86/255, blue: 81/255)
    let green2 = Color(red: 52/255, green: 133/255, blue: 53/255)
    let teal = Color(red: 70/255, green: 156/255, blue: 153/255)
        
    // gradients
    let blueGradient = [Color(red: 33/255, green: 147/255, blue: 176/255), Color(red: 109/255, green: 213/255, blue: 237/255)]
    let pinkGradient = [Color(red: 255/255, green: 175/255, blue: 189/255), Color(red: 255/255, green: 195/255, blue: 160/255)]

    
}
