//
//  AppDelegate.swift
//  SellerApp
//
//  Created by Berdil Ilyada Karacam on 17.11.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appRouter = AppRouter(window: window)
        self.window = window
        
        setupNavigationBar()
        
        appRouter.start()
        return true
    }
}

private extension AppDelegate {
    func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = .blue
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
