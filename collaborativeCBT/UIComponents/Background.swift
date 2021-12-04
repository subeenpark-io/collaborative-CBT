//
//  Background.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .overlay(content)
    }
}
