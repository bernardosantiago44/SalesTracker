//
//  NewProductViewModel.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/02/24.
//

import Foundation
import SwiftUI

@Observable
final class NewProductViewModel {
    var name: String
    var price: Float
    var color: Color
    var category: ProductCategory?
    var inventoryTracking: Bool
    var currentInventory: UInt
    var lowInventoryNotification: UInt?
    var barcode: String
    
    init() {
        self.name = "Product name"
        self.price = 0
        self.color = .green
        self.inventoryTracking = true
        self.currentInventory = 0
        self.lowInventoryNotification = nil
        self.barcode = ""
    }
    
    init(from product: Product) { // Delegate init
        self.name = product.name
        self.price = product.getPrice()
        self.color = CustomColor(rawValue: product.color)?.color ?? .primary
        self.category = product.category
        self.inventoryTracking = product.inventoryTracking
        self.currentInventory = product.currentInventory
        self.lowInventoryNotification = product.lowInventoryNotification
        self.barcode = product.barcode ?? ""
    }
    
    var isInvalid: Bool {
        return self.name.tidy.isEmpty || self.price <= 0 || category == nil
    }
}
