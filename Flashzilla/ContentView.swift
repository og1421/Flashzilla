//
//  ContentView.swift
//  Flashzilla
//
//  Created by Orlando Moraes Martins on 14/01/23.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello World")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
