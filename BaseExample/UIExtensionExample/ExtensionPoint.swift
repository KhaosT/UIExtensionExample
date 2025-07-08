//
//  ExtensionPoint.swift
//  UIExtensionExample
//
//  Created by Khaos Tian on 6/9/25.
//

import Foundation
import ExtensionFoundation

extension AppExtensionPoint {

    @Definition
    public static var customUIExtension: AppExtensionPoint {
        Name("customUI")
        UserInterface()
    }
}
