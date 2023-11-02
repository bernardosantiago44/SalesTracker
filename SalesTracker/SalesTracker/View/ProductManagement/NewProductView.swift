//
//  NewProductView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct NewProductView: View {
    @ObservedObject var salesModel: SalesModel
    @State private var product = Product()
    var body: some View {
        Form {
            Section {
                TextField("productname", text: $product.name)
            }
        }
    }
}

#Preview {
    NewProductView(salesModel: SalesModel())
}
