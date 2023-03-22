//
//  AppDelegate.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import SwiftUI
import Firebase
import FacebookLogin
import FirebaseMessaging
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application,
                                               didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        requestAuthorizationForPushNotification(application: application)
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    private func requestAuthorizationForPushNotification(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

@main
struct SaveLinkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView().environmentObject(SessionStore())
        }
    }
}

/*
 @main
 struct SaveLinkApp: App {
     
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
     @StateObject var authenticationViewModel = AuthenticationViewModel(service: NetworkServiceFactory.create())

     var body: some Scene {
         WindowGroup {
             TopBarContentView(authenticationViewModel: authenticationViewModel).environmentObject(SessionStore())
         }
     }
 }
 */
