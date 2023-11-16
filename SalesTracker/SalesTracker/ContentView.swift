//
//  ContentView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var sharedModel: SalesModel
    var body: some View {
        NavigationStack {
            LoginView()
        }
    }
}

#Preview {
    ContentView(sharedModel: SalesModel())
}
