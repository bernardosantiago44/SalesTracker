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
    @StateObject var productsModel = ProductsModel()
    @StateObject var appNavigation = AppNavigation()
    @StateObject var salesModel = SalesModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(productsModel: self.productsModel, appNavigation: self.appNavigation, salesModel: self.salesModel)
        }
    }
}
