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
    @StateObject var authenticationViewModel = AuthenticationViewModel()
//    @StateObject var remoteConfiguration = RemoteConfiguration()
    
    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user {
                HomeContentView(authenticationViewModel: authenticationViewModel)
//                    .environmentObject(remoteConfiguration)
            } else {
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}

//final class RemoteConfiguration: ObservableObject {
//    @Published var buttonTitle: String = ""
//    var remoteConfig: RemoteConfig
//
//    init() {
//        remoteConfig = RemoteConfig.remoteConfig()
//        let settings = RemoteConfigSettings()
//        settings.minimumFetchInterval = 30
//        remoteConfig.configSettings = settings
//        remoteConfig.setDefaults(["create_button_title" : "Cargando..." as NSObject])
//        buttonTitle = remoteConfig.configValue(forKey: "create_button_title").stringValue ?? ""
//    }
//
//    func fetch() {
//        remoteConfig.fetchAndActivate { [weak self] success, error in
//            if let error = error {
//                print("Error \(error.localizedDescription)")
//                return
//            }
//            DispatchQueue.main.async {
//                self?.buttonTitle = self?.remoteConfig.configValue(forKey: "create_button_title").stringValue ?? ""
//            }
//        }
//    }
//}
