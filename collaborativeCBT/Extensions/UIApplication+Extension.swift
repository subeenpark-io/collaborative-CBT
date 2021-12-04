//
//  UIApplication+Extension.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
