//
//  NewProductView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import CodeScanner
import SwiftUI

struct NewProductView: View {
    @ObservedObject var salesModel: ProductsModel
    @Environment(\.dismiss) private var dismiss
    @State private var newProduct = NewProductViewModel()
    @State private var showsNewCategorySheet = false
    @State private var showsCodeScanner = false
    @State private var newCategoryName = ""
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                // Name and price
                Section {
                    TextField("productname", text: $newProduct.name)
                    TextField(value: $newProduct.price, format: .number.precision(.fractionLength(2))) {
                        Text("productprice")
                    }
                    .keyboardType(.decimalPad)
                    
                }
                // Category and color
                Section {
                    CategoryPicker(salesModel: self.salesModel, selection: $newProduct.category)
                    ColorPicker(selectedColor: $newProduct.color)
                } header: {
                    HStack {
                        Text("category")
                        Spacer()
                        Button {
                            self.showsNewCategorySheet.toggle()
                            self.newProduct.category = nil
                        } label: {
                            Text("add_category")
                                .font(.footnote)
                        }
                    }
                }
                
                // Inventory
                Section("inventory") {
                    Toggle(isOn: $newProduct.inventoryTracking) {
                        Text("inventory_followup")
                    }
                    if newProduct.inventoryTracking {
                        VStack(alignment: .leading) {
                            Text("current_inventory")
                                .font(.footnote)
                            TextField("10", value: $newProduct.currentInventory, format: .number)
                                .keyboardType(.numberPad)
                        }
                        lowInventoryNotificationsField
                    }
                }
                
                // Code
                Section("code") {
                    Text("barcode_description")
                        .font(.callout)
                    HStack {
                        TextField("barcode", text: $newProduct.barcode)
                        Spacer()
                        Button {
                            self.showsCodeScanner.toggle()
                        } label: {
                            Image(systemName: "qrcode.viewfinder")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("done") {
                        let product = Product(from: self.newProduct)
                        if product.isValid() {
                            self.salesModel.addProductToCatalog(product)
                            dismiss()
                        }
                    }
                    .disabled(self.newProduct.isInvalid || self.salesModel.actionResponse == .InProgress)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .sheet(isPresented: self.$showsNewCategorySheet, content: {
                HStack {
                    TextField("add_category", text: $newCategoryName)
                        .textFieldStyle(RoundedGroupTextFieldStyle())
                    .presentationDetents([.fraction(0.20)])
                    Button("add") {
                        let newCategory = ProductCategory(category: self.newCategoryName)
                        self.salesModel.registerCategory(newCategory)
                        self.newProduct.category = newCategory
                        self.showsNewCategorySheet = false
                        self.newCategoryName = ""
                    }
                    .disabled(self.newCategoryName.tidy.isEmpty || self.salesModel.categories.contains{ $0.categoryName.tidy == self.newCategoryName.tidy })
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            })
            .sheet(isPresented: self.$showsCodeScanner) {
                CodeScannerView(codeTypes: [.qr, .upce, .ean8, .ean13, .code128], simulatedData: "123456", completion: handleScan)
            }
            .animation(.default, value: newProduct.inventoryTracking)
        }
    }
    var lowInventoryNotificationsField: some View {
        VStack(alignment: .leading) {
            Text("low_inventory_notifications")
                .font(.footnote)
            HStack {
                TextField("no_notifications", value: $newProduct.lowInventoryNotification, format: .number)
                Spacer()
                Button {
                    if newProduct.lowInventoryNotification == nil {
                        newProduct.lowInventoryNotification = 0
                    } else {
                        newProduct.lowInventoryNotification = nil
                    }
                } label: {
                    Image(systemName: "bell")
                        .symbolVariant(newProduct.lowInventoryNotification == nil ? .none : .slash)
                }
            }
            .animation(.default, value: newProduct.lowInventoryNotification)
        }
    }
    
    private func handleScan(result: Result<ScanResult, ScanError>) {
        self.showsCodeScanner = false
        
        switch result {
        case .success(let success):
            self.newProduct.barcode = success.string
        case .failure(let failure):
            // FIXME: Show error to the user
            print(failure.localizedDescription)
        }
    }
}

#Preview {
    NewProductView(salesModel: ProductsModel())
}
