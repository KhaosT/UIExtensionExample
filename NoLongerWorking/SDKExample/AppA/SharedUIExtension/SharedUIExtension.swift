//
//  SharedUIExtension.swift
//  SharedUIExtension
//
//  Created by Khaos Tian on 6/17/25.
//

import Foundation
import ExtensionFoundation
import ExtensionKit
import SwiftUI

/// The AppExtensionConfiguration that will be provided by this extension.
/// This is typically defined by the extension host in a framework.
struct ExampleConfiguration<E:ExampleExtension>: AppExtensionConfiguration {
    
    let appExtension: E
    
    init(_ appExtension: E) {
        self.appExtension = appExtension
    }
    
    /// Determine whether to accept the XPC connection from the host.
    func accept(connection: NSXPCConnection) -> Bool {
        // TODO: Configure the XPC connection and return true
        return false
    }
}

/// The AppExtension protocol to which this extension will conform.
/// This is typically defined by the extension host in a framework.
protocol ExampleExtension : AppExtension {
    associatedtype Body: ExampleAppExtensionScene
    var body: Body { get }
}

/// The AppExtensionScene protocol to which this extension's scenes will conform.
/// This is typically defined by the extension host in a framework.
protocol ExampleAppExtensionScene: AppExtensionScene {}

/// An AppExtensionScene that this extension can provide.
/// This is typically defined by the extension host in a framework.
struct ExampleScene<Content: View>: ExampleAppExtensionScene {
    
    let sceneID = "example-scene"
    
    public init(content: @escaping () ->  Content) {
        self.content = content
    }
    
    private let content: () -> Content
    
    public var body: some AppExtensionScene {
        PrimitiveAppExtensionScene(id: sceneID) {
            content()
        } onConnection: { connection in
            // TODO: Configure the XPC connection and return true
            return false
        }
    }
}

extension ExampleExtension {
    var configuration: AppExtensionSceneConfiguration {
        // Return your extension's configuration upon request.
        return AppExtensionSceneConfiguration(self.body, configuration: ExampleConfiguration(self))
    }
}

@main
class SharedUIExtension: ExampleExtension {
    required init() {
        // Initialize your extension here.
    }

    @AppExtensionPoint.Bind
    var boundExtensionPoint: AppExtensionPoint {
        AppExtensionPoint.Identifier(host: "app.cerio.AppA", name: "SharedUI")
    }
    
    var body: some ExampleAppExtensionScene {
        ExampleScene {
            Text("This is an extension provided by AppA")
        }
    }
}
