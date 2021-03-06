//
//  AppDelegate.swift
//  weibo
//
//  Created by 2020 on 2020/7/24.
//  Copyright © 2020 2020. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var defaultViewVC : UIViewController? {
        let islogIn = UserAccountViewModel.sharIntance.isLogin
        return islogIn ? WelComeController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultViewVC
        window?.makeKeyAndVisible()
        
        
        
        return true
    }


}

