//
//  NewProductView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import SwiftUI

struct NewProductView: View {
    @ObservedObject var salesModel: SalesModel
    @Environment(\.dismiss) private var dismiss
    @State private var productName = "Product name"
    @State private var productPrice: Float = 0
    @State private var productColor: Color = .green
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    var isInvalidProduct: Bool {
        return self.productName.isEmpty || self.productPrice <= 0
    }
    
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
                    let product = Product(name: self.productName, category: "", color: self.productColor, price: self.productPrice, rating: 5)
                    if product.isValid() {
                        self.salesModel.addProductToCatalog(product)
                        dismiss()
                    }
                } label: {
                    Text("done")
                }
                .disabled(self.isInvalidProduct)
        })
        }
    }
}

#Preview {
    NewProductView(salesModel: SalesModel())
}
