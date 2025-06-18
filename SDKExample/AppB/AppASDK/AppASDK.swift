//
//  AppASDK.swift
//  AppASDK
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
            let monitor = try await AppExtensionPoint.Monitor(
                appExtensionPoint: AppExtensionPoint(identifier: "app.cerio.AppA.SharedUI")
            )
            NSLog("Identities: \(monitor.identities)")
            currentIdentity = monitor.identities.first

            self.monitor = monitor
        } catch {
            NSLog("Error: %@", String(describing: error))
        }
    }
}

public struct AppAExtensionView: View {

    @State
    private var viewModel = ViewModel()

    public init() {}

    public var body: some View {
        VStack {
            if let currentIdentity = viewModel.currentIdentity {
                CustomExtensionView(
                    identity: currentIdentity,
                    sceneID: "example-scene"
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
