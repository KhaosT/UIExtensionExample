//
//  CustomExtensionView.swift
//  AppB
//
//  Created by Khaos Tian on 6/17/25.
//

import ExtensionFoundation
import ExtensionKit
import SwiftUI

struct CustomExtensionView: UIViewControllerRepresentable {

    let identity: AppExtensionIdentity
    let sceneID: String

    func makeUIViewController(context: Context) -> EXHostViewController {
        let viewController = EXHostViewController()

        viewController.configuration = EXHostViewController.Configuration(
            appExtension: identity,
            sceneID: sceneID
        )

        return viewController
    }

    func updateUIViewController(
        _ uiViewController: EXHostViewController,
        context: Context
    ) {
        uiViewController.configuration = EXHostViewController.Configuration(
            appExtension: identity,
            sceneID: sceneID
        )
    }
}
