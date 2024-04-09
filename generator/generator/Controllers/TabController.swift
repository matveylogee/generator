//
//  TabController.swift
//  generator
//
//  Created by Матвей on 23.03.2024.
//

import UIKit

enum Theme: Int {
    case device
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor(named: "backgroundColor")
        self.tabBar.tintColor = UIColor(named: "otherColors")
        self.tabBar.unselectedItemTintColor = .darkGray
        
        setupTabs()
    }

    // MARK: - setup Tab
    private func setupTabs() {
        
        let home = self.createNav(with: "Меню", and: UIImage(systemName: "house"), vc: HomeController())
        let library = self.createNav(with: "Библиотека", and: UIImage(systemName: "clock"), vc: LibraryController())
        let settings = self.createNav(with: "Настройки", and: UIImage(systemName: "person"), vc: SettingsController())
        
        
        self.setViewControllers([home, library, settings], animated: true)
        
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationItem.backBarButtonItem?.title = "Назад"
        
//        nav.viewControllers.first?.navigationItem.title = title
        
        return nav
    }
}
