//
//  AppNavigation.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 16/11/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

/// Used to keep track of App's navigation.
/// 
@MainActor
final class AppNavigation: ObservableObject {
    @Published var loginPath: NavigationPath
    @Published var productsNavigationPath: NavigationPath
    @Published var askForLogin: Bool
    @Published var selectedTab: AppPages
    
    init() {
        self.loginPath = NavigationPath()
        self.productsNavigationPath = NavigationPath()
        selectedTab = .productsList
        if Auth.auth().currentUser != nil {
            self.askForLogin = false
        } else {
            self.askForLogin = true
        }
    }
    
    func goToMainView() {
        self.productsNavigationPath = NavigationPath()
    }
    
    func goToMainTab() {
        self.selectedTab = .productsList
    }
}

enum AppPages: String, Hashable {
    case productsList = "productsList"
    case account = "account"
    case trends = "chart.line.uptrend.xyaxis"
}
