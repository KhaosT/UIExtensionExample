//
//  ContentView.swift
//  AppA
//
//  Created by Khaos Tian on 6/17/25.
//

import ExtensionFoundation
import SwiftUI
import Observation

@Observable
final class ViewModel {

    private var monitor: AppExtensionPoint.Monitor?
    private(set) var currentIdentity: AppExtensionIdentity?

    private(set) var disabledExtensionCount: Int = 0

    func load() async {
        do {
            let monitor = AppExtensionPoint.Monitor()

            try await monitor.addAppExtensionPoint(.customPluginExtension)
            self.monitor = monitor

            observeUpdates()
        } catch {
            NSLog("Error: %@", String(describing: error))
        }
    }

    func observeUpdates() {
        guard let monitor else {
            return
        }

        withObservationTracking {
            NSLog("Identities: \(monitor.identities)")
            NSLog("Count: \(monitor.state.disabledCount) | \(monitor.state.unapprovedCount)")
            currentIdentity = monitor.identities.first
            disabledExtensionCount = monitor.state.disabledCount
        } onChange: { [weak self] in
            DispatchQueue.main.async {
                self?.observeUpdates()
            }
        }
    }
}

struct ContentView: View {

    @State
    private var viewModel = ViewModel()

    @State
    private var showBrowser = false

    var body: some View {
        VStack {
            if let currentIdentity = viewModel.currentIdentity {
                CustomExtensionView(
                    identity: currentIdentity,
                    sceneID: "testScene"
                )
            } else {
                Text("No Extension")

                if viewModel.disabledExtensionCount > 0 {
                    Text("Disabled: \(viewModel.disabledExtensionCount)")
                }
            }
        }
        .task {
            await viewModel.load()
        }
        .sheet(isPresented: $showBrowser, content: {
            ExtensionBrowserView()
                .presentationDetents([.medium, .large])
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            showBrowser = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        })
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    showBrowser = true
                } label: {
                    Image(systemName: "switch.2")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

