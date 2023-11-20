//
//  SalesTrackerApp.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SalesTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var salesModel = SalesModel()
    @StateObject var appNavigation = AppNavigation()
    
    var body: some Scene {
        WindowGroup {
            ContentView(sharedModel: self.salesModel, appNavigation: self.appNavigation)
        }
    }
}
