//
//  ContentView.swift
//  UIExtensionExample
//
//  Created by Khaos Tian on 6/9/25.
//

import ExtensionFoundation
import SwiftUI
import Observation

@Observable
final class ViewModel {

    private var monitor: AppExtensionPoint.Monitor?
    private(set) var currentIdentity: AppExtensionIdentity?

    func load() async {
        do {
            let monitor = try await AppExtensionPoint.Monitor(appExtensionPoint: .customUIExtension)
            NSLog("Identities: \(monitor.identities)")
            NSLog("States: \(monitor.state.disabledCount) | \(monitor.state.unapprovedCount)")
            currentIdentity = monitor.identities.first

            self.monitor = monitor
        } catch {
            NSLog("Error: %@", String(describing: error))
        }
    }
}

struct ContentView: View {

    @State
    private var viewModel = ViewModel()

    var body: some View {
        VStack {
            if let currentIdentity = viewModel.currentIdentity {
                CustomExtensionView(
                    identity: currentIdentity,
                    sceneID: Constants.sceneID
                )
            } else {
                Text("No Extension")
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    ContentView()
}
