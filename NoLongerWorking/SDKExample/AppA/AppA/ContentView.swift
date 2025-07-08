//
//  ContentView.swift
//  AppA
//
//  Created by Khaos Tian on 6/17/25.
//

import SwiftUI
import AppASDK

struct ContentView: View {

    var body: some View {
        VStack {
            Text("App that provides the extension to others.")
            AppAExtensionView()
        }
    }
}

#Preview {
    ContentView()
}

