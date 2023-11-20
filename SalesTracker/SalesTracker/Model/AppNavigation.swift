//
//  AppNavigation.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 16/11/23.
//

import Foundation
import SwiftUI

/// Used to keep track of App's navigation.
/// 
final class AppNavigation: ObservableObject {
    @Published var path = NavigationPath()
    
    func goToMainView() {
        self.path = NavigationPath([AppPages.productsList])
    }
    
    func goToAuthView() {
        self.path = NavigationPath()
    }
}

enum AppPages: String, Hashable {
    case authentication = "authentication"
    case productsList = "productsList"
}
