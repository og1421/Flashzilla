//
//  ContentView.swift
//  Flashzilla
//
//  Created by Orlando Moraes Martins on 14/01/23.
//

import SwiftUI

func withOptionalAnimation <Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello World")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation{
                    scale *= 1.5
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
