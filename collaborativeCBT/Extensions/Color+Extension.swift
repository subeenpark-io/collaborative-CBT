//
//  Color+Extension.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

extension Color {
    
    static var mainYellow: Color { hex("#666666") }
    static var mainPurple: Color { fetchColor(#function) }
    static var titlePurple: Color { fetchColor(#function) }
    static var subtitlePurple: Color { fetchColor(#function) }
    static var bgGray: Color { fetchColor(#function) }
    static var textGray: Color { fetchColor(#function) }
    static var strongGray: Color { hex("#555555") }
    static var subGray: Color { fetchColor(#function) }
    
    
    private static func fetchColor(_ name: String) -> Color {
        return Color(name)
    }
    
    private static func hex(_ hex: String) -> Color {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        return Color(red: r, green: g, blue: b)
    }
    
}
