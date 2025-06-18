//
//  ContentView.swift
//  AppB
//
//  Created by Khaos Tian on 6/17/25.
//

import SwiftUI
import AppASDK

struct ContentView: View {
    var body: some View {
        VStack {
            Text("This is App B")
            AppAExtensionView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
