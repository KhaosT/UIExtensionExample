//
//  CustomUIExtension.swift
//  CustomUIExtension
//
//  Created by Khaos Tian on 6/9/25.
//

import Foundation
import ExtensionFoundation
import ExtensionKit
import SwiftUI

struct CustomUIExtensionConfiguration<E: MyUIExtension>: AppExtensionConfiguration {

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

protocol MyUIExtension : AppExtension {
    associatedtype Body: CustomUIExtensionScene
    var body: Body { get }
}

protocol CustomUIExtensionScene: AppExtensionScene {}

struct ExtensionScene<Content: View>: CustomUIExtensionScene {

    let sceneID = Constants.sceneID

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

extension MyUIExtension {

    var configuration: AppExtensionSceneConfiguration {
        return AppExtensionSceneConfiguration(
            self.body,
            configuration: CustomUIExtensionConfiguration(self)
        )
    }
}

@main
class CustomUIExtension: MyUIExtension {

    required init() {
        // Initialize your extension here.
    }

    @AppExtensionPoint.Bind
    var boundExtensionPoint: AppExtensionPoint {
        AppExtensionPoint.Identifier(host: "app.cerio.UIExtensionExample", name: "app.cerio.UIExtensionExample.customUI")
    }
    
    var body: some CustomUIExtensionScene {
        ExtensionScene {
            MyCustomView()
        }
    }
}
