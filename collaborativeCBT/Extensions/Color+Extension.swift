//
//  Color+Extension.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

extension Color {
    
    static var mainYellow: Color { fetchColor(#function) }
    static var mainPurple: Color { fetchColor(#function) }
    static var titlePurple: Color { fetchColor(#function) }
    static var subtitlePurple: Color { fetchColor(#function) }
    static var bgGray: Color { fetchColor(#function) }
    static var textGray: Color { fetchColor(#function) }
    static var subGray: Color { fetchColor(#function) }
    
        
    private static func fetchColor(_ name: String) -> Color {
        return Color(name)
    }
    
}
