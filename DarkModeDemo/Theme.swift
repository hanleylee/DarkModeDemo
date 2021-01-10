//
//  Theme.swift
//  HLTest
//
//  Created by Hanley Lee on 2021/01/09.
//  Copyright © 2021 Hanley Lee. All rights reserved.
//

import UIKit

enum Theme: Int, CaseIterable {
    case none = 0
    case light = 1
    case dark = 2

    var title: String {
        switch self {
            case .none: return "Follow"
            case .light: return "Light"
            case .dark: return "Dark"
        }
    }

    @available(iOS 13.0, *)
    var mode: UIUserInterfaceStyle {
        switch self {
            case .none: return .unspecified
            case .light: return .light
            case .dark: return .dark
        }
    }
}

