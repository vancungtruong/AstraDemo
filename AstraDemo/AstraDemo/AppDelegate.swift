//
//  AppDelegate.swift
//  AstraDemo
//
//  Created by cuong on 3/18/22.
//

import UIKit

import AstraLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAstraLib(application, launchOptions: launchOptions)

        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate {
    
    func setupAstraLib(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        CTPurchaseKit.config()
        AdjustTracking.config(appToken: AdjustToken.appToken)
        FacebookTracking.config(application: application, launchOptions: launchOptions)
        FirebaseTracking.config()
        setupRemoteNotification()
    }
    
    private func setupRemoteNotification() {
        
        let notificationDelegate = DefaultNotificationHanlder()
        notificationDelegate.notificationHandler = { userInfo in
            
        }
        RemoteNotificationRegister.shared.configure(delegate: notificationDelegate)
        RemoteNotificationRegister.shared.deviceTokenHanlder = { deviceToken in
            // save deviceToken & call api
        }
        RemoteNotificationRegister.shared.failToRegisterHanlder = { error in
            // handle error deviceToken
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return FacebookTracking.application(app, open: url, options: options)
    }
    
}
