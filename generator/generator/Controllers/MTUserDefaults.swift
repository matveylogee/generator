//
//  MTUserDefaults.swift
//  generator
//
//  Created by Матвей on 01.04.2024.
//

import Foundation
import UIKit

struct MTUserDefaults {
    
    static var shared = MTUserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
    
    mutating func setTheme(_ theme: Theme) {
        self.theme = theme
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = theme.getUserInterfaceStyle()
            }
        }
    }
}
