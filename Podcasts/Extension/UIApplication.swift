//
//  UIApplication.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 10.07.2023.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
