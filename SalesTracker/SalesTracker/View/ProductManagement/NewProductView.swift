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
    @State private var productName = "Product name"
    @State private var productPrice: Float = 0
    @State private var productColor: Color = .green
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("productname", text: $productName)
                    TextField(value: $productPrice, format: .currency(code: self.currencyCode)) {
                        Text("productprice")
                    }
                }
                Section {
                    ColorPicker(selectedColor: $productColor)
                }
            }
            .toolbar(content: {
                Button {
                    
                } label: {
                    Text("done")
                }

        })
        }
    }
}

#Preview {
    NewProductView(salesModel: SalesModel())
}
