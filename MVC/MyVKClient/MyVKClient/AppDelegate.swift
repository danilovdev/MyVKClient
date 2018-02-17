//
//  AppDelegate.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 10.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

/*
 sources:
 1. https://vk.com/dev/ios_sdk
 2. https://github.com/VKCOM/vk-ios-sdk
 3. https://habrahabr.ru/company/microsoft/blog/323296/
 4. https://stackoverflow.com/questions/36118158/how-to-logout-from-vk-api-on-ios
 5.
 */

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = .white
        navBarAppearance.barTintColor = #colorLiteral(red: 0.2963480353, green: 0.4561202526, blue: 0.6371127963, alpha: 1)
        navBarAppearance.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = VKSdk.processOpen(url, fromApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String)
        return result
    }


}

