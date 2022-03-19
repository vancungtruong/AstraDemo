# AstraLib Demo

[![CI Status](https://img.shields.io/travis/Cung Truong/AstraLib.svg?style=flat)](https://travis-ci.org/Cung Truong/AstraLib)
[![Version](https://img.shields.io/cocoapods/v/AstraLib.svg?style=flat)](https://cocoapods.org/pods/AstraLib)
[![License](https://img.shields.io/cocoapods/l/AstraLib.svg?style=flat)](https://cocoapods.org/pods/AstraLib)
[![Platform](https://img.shields.io/cocoapods/p/AstraLib.svg?style=flat)](https://cocoapods.org/pods/AstraLib)


## Features

- In-App Purchase
- Remote notification
- Adjust tracking
- Firebase tracking
- Facebook tracking


## Requirements

| iOS |
| --- |
| 8.0 |


## Cocoapods

AstraLib is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```swift
use_frameworks!

pod 'AstraLib'
```

## Document

### Setup 

[Adjust](https://github.com/adjust/ios_sdk)
[Firebase](https://firebase.google.com/docs/analytics/get-started?platform=ios)
[Facebook](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios)

### AppDelegate.swift

```swift

import AstraLib

class AppDelegate: UIResponder, UIApplicationDelegate { 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAstraLib(application, launchOptions: launchOptions)

        
        return true
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

```

### SceneDelegate.swift

```swift

import AstraLib

extension SceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        guard let url = URLContexts.first?.url else {
            return
        }

        FacebookTracking.open(url: url)
    }
}


```

## Author

Cung Truong, vancungtruong@gmail.com

## License

AstraLib is available under the MIT license. See the LICENSE file for more info.
