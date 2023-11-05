//
//  SalesTrackerApp.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

@main
struct SalesTrackerApp: App {
    @StateObject var salesModel = SalesModel()
    var body: some Scene {
        WindowGroup {
            ContentView(sharedModel: self.salesModel)
        }
    }
}
