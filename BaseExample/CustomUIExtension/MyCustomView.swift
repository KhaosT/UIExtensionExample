//
//  MyCustomView.swift
//  UIExtensionExample
//
//  Created by Khaos Tian on 6/9/25.
//

import SwiftUI

struct MyCustomView: View {

    @State
    private var counter: Int = 0

    var body: some View {
        VStack {
            Text("Count: \(counter)")

            Button("Tap") {
                counter += 1
            }
        }
    }
}
