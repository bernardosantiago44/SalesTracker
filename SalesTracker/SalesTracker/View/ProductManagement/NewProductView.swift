//
//  NewProductView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct NewProductView: View {
    @ObservedObject var salesModel: SalesModel
    @State private var productName = "Product name"
    @State private var categoryColor: Color = .green
    @State private var productPrice: Float = 0
    let currencyCode = Locale.current.currency?.identifier ?? "usd"
    
    var body: some View {
        Form {
            Section {
                TextField("productname", text: $productName)
                TextField(value: $productPrice, format: .currency(code: self.currencyCode)) {
                    Text("currency")
                }
            }
            Section {
                ColorPicker(selectedColor: self.$categoryColor)
            }
        }
    }
}

#Preview {
    NewProductView(salesModel: SalesModel())
}
