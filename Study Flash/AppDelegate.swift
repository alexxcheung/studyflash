//
//  AppDelegate.swift
//  Study Flash
//
//  Created by Zarioiu Bogdan on 5/7/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //delaying launch screen
        Thread.sleep(forTimeInterval: 2.0)
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        stateManager.updateState()

        //for configuring testing
        let testing = false
        if testing {
            
            stateManager.state = .firstLaunch
            stateManager.logState = .loggedOut
            
            UserDefaults.standard.set(false, forKey: "isTodayCourseFinished")
            UserDefaults.standard.set(false, forKey: "isCourseSelected")
            UserDefaults.standard.synchronize()
            
        }
        
        if stateManager.state == .firstLaunch {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let onboardingViewController = OnboardingViewController(collectionViewLayout: layout)
            
            window?.rootViewController = onboardingViewController
            
        } else {
            let story = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainViewController = story.instantiateViewController(withIdentifier: "TabBarController")
            
            window?.rootViewController = mainViewController
            window?.rootViewController?.modalPresentationStyle = .fullScreen
        }
        
        // Push Notifications
        registerForPushNotifications()
        
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

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // MARKS: - Push Notification
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
//            self.getNotificationSettings()
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    //
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
      }
    }
    


    
    //Restortion
//    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
//        return true
//    }
//
//    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
//        return true
//    }

}

