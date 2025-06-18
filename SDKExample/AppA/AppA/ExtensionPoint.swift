//
//  ExtensionPoint.swift
//  AppA
//
//  Created by Khaos Tian on 6/17/25.
//

import Foundation
import ExtensionFoundation

extension AppExtensionPoint {

    @Definition
    public static var sharedUIExtension: AppExtensionPoint {
        Name("SharedUI")
        UserInterface()
        Scope(restriction: .none)
    }
}
