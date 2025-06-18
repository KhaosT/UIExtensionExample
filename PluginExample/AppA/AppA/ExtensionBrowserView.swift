//
//  ExtensionBrowserView.swift
//  AppA
//
//  Created by Khaos Tian on 6/17/25.
//

import ExtensionFoundation
import ExtensionKit
import SwiftUI

struct ExtensionBrowserView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> EXAppExtensionBrowserViewController {
        let viewController = EXAppExtensionBrowserViewController()
        return viewController
    }

    func updateUIViewController(
        _ uiViewController: EXAppExtensionBrowserViewController,
        context: Context
    ) {}
}
