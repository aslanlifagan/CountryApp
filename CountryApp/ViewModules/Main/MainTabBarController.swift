//
//  MainTabBarController.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit
//import Threads

final class MainTabBarC: UITabBarController {

    var previousController: UIViewController?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.setupUI()
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .mainGreen
        tabBar.isTranslucent = false
        tabBar.barTintColor = .mainOrange
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        
        let countryVC = BaseNC(rootViewController: CountryVC())
        countryVC.tabBarItem = UITabBarItem(title: "Country", image: UIImage(systemName: "globe"), selectedImage: UIImage(systemName: "globe.fill"))
        countryVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -4)
        
        let otherVC = BaseNC(rootViewController: QuestionsVC())
        otherVC.tabBarItem = UITabBarItem(title: "Questions", image: UIImage(systemName: "questionmark.folder"), selectedImage: UIImage(systemName: "questionmark.folder.fill"))
        otherVC.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -4)
        
        let controllers = [countryVC, otherVC]
        self.viewControllers = controllers
    }
}


// MARK: - UITabBarController Delegate

extension MainTabBarC: UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if previousController == viewController {
//            if let navigation = viewController as? UINavigationController {
//                guard let topController = navigation.viewControllers.last else { return }
//                if !topController.isScrolledToTop {
//                    topController.scrollToTop()
//                }
//            }
//        }
//        previousController = viewController
//    }
}
