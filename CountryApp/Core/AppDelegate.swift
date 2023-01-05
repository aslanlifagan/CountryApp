//
//  AppDelegate.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var welcomeMainVC: BaseNC?
    static let shared = UIApplication.shared.delegate as! AppDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if DefaultsStorage.getBool(by: .UD_KEY_LOGIN) {
            //            self.passcodeVC = PasscodeVC()
            //            window?.rootViewController = self.passcodeVC
            //            window?.makeKeyAndVisible()
        }
        else {
            self.welcomeMainVC = BaseNC(rootViewController: WelcomeVC())
            window?.rootViewController = welcomeMainVC
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    // MARK: - Login & Logout
    
    func login() {
        DefaultsStorage.set(bool: true, by: .UD_KEY_LOGIN)
//        self.window?.rootViewController?.dismiss(animated: false, completion: nil)
//        self.window?.rootViewController = nil
        
//        self.mainVC = MainTabBarC()
//        window?.rootViewController = self.mainVC
//        window?.makeKeyAndVisible()
    }	
    
    func logout(_ force: Bool = true) {
        if force {
//            KeychainService.removeSession(service: UD_KEY_SESSION)
//            DefaultsStorage.remove(key: UD_KEY_LOGOUT)
//            DefaultsStorage.remove(key: UD_KEY_LOGIN)
//            DefaultsStorage.remove(key: UD_KEY_SESSION)
//            DefaultsStorage.remove(key: UD_KEY_PASSCODE)
//            DefaultsStorage.remove(key: UD_KEY_UNLOCK_TOUCH_ID)
//            DefaultsStorage.remove(key: UD_KEY_UNLOCK_FACE_ID)
        }
        else {
            DefaultsStorage.set(bool: false, by: .UD_KEY_LOGIN)
        }
        
        self.window?.rootViewController?.dismiss(animated: false, completion: nil)
        self.window?.rootViewController = nil
        
        self.welcomeMainVC = BaseNC(rootViewController: WelcomeVC())
        window?.rootViewController = self.welcomeMainVC
        window?.makeKeyAndVisible()
//        self.mainVC = nil
    }
}

