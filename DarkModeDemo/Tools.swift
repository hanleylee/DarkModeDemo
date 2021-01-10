//
//  TestMethod.swift
//  HLTest
//
//  Created by Hanley Lee on 2020/10/19.
//  Copyright © 2020 Hanley Lee. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    @UserDefaultStorage(keyName: "appTheme")
    static var _style: Int?

    static var style: Theme {
        get { return Theme(rawValue: (_style ?? 0)) ?? .dark }
        set { _style = newValue.rawValue }
    }

    /// 创造颜色, 核心方法
    static func makeColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .light ? light : dark }
        } else {
            return Tools.style == .light ? light : dark
        }
    }

    /// 创造 img, 核心方法
    static func makeImage(light: UIImage, dark: UIImage) -> UIImage {
        if #available(iOS 13.0, *) {
            let image = UIImage()
            image.imageAsset?.register(light, with: .init(userInterfaceStyle: .light))
            image.imageAsset?.register(dark, with: .init(userInterfaceStyle: .dark))
            return image
        } else {
            return Tools.style == .light ? light : dark
        }
    }

    /// 设置 tabVC
    static func getTabVC(withIndex index: Int) -> UITabBarController {
        var vcArr: [TestVC] = []

        for i in 0 ..< 4 {
            let vc = TestVC(index: i)
            vc.tabBarItem = .init(title: "\(i)", image: UIImage(named: "setting"), tag: i)
            vcArr.append(vc)
        }

        let tabVC = UITabBarController()
        tabVC.viewControllers = vcArr
        tabVC.selectedIndex = index

        return tabVC
    }
}
