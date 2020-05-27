//
//  AppDelegate.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 30.10.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth
import UserNotifications
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        
        if #available(iOS 10, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert], completionHandler: { (granted, error) in
                application.registerForRemoteNotifications()
            })
        }
        else{
            let notificationSettings = UIUserNotificationSettings(types: [.badge,.alert,.sound],categories:nil)
            
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        
        UITabBar.appearance().tintColor = UIColor.red
        //UIApplication.shared.statusBarStyle = .lightContent
        let higdef = UserDefaults.standard
        higdef.setValue(1, forKey: "Highscore")
        higdef.synchronize()
        // Override point for customization after application launch.
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }
    
    // MARK: - Core Data stack
    
    // MARK: - Core Data Saving support
    
}

