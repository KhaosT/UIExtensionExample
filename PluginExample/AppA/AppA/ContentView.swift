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

    func load() async {
        do {
            let monitor = try await AppExtensionPoint.Monitor(appExtensionPoint: .customPluginExtension)
            NSLog("Identities: \(monitor.identities)")
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

            ToolbarItem(placement: .bottomBar) {
                Button {
                    Task {
                        await viewModel.load()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }

            }
        }
    }
}

#Preview {
    ContentView()
}

