//
//  Product.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import Foundation
import SwiftUI

struct Product: Identifiable, Hashable, Codable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    
    var name: String
    
    var category: ProductCategory
    
    var color: String
    
    var rating: Float
    
    var inventoryTracking: Bool
    var currentInventory: UInt
    var lowInventoryNotification: UInt?
    
    var barcode: String?
    
    private var price: Float
    
    init() {
        self.init(name: "Product name",
                  category: .defaultCategory,
                  color: .green,
                  price: 1,
                  rating: 5)
    }
    
    init(name: String, category: ProductCategory, color: Color, price: Float, rating: Float) {
        assert(!name.isEmpty, "Name can't be empty")
        assert(price > 0, "Price must be > 0.")
        assert(rating >= 0 && rating <= 5, "Rating must be between 0 and 5.")
        
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.color = color.description
        self.price = price
        self.rating = rating
        self.currentInventory = 0
        self.inventoryTracking = false
    }
    
    init(name: String, 
         category: ProductCategory,
         color: Color,
         price: Float,
         rating: Float,
         currentInventory: UInt,
         lowInventoryNotification: UInt? = nil,
         barcode: String? = nil) {
        assert(!name.isEmpty, "Name can't be empty")
        assert(price > 0, "Price must be > 0.")
        assert(rating >= 0 && rating <= 5, "Rating must be between 0 and 5.")
        
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.color = color.description
        self.price = price
        self.rating = rating
        self.currentInventory = currentInventory
        self.inventoryTracking = true
        self.lowInventoryNotification = lowInventoryNotification
        self.barcode = barcode == nil ? "" : barcode!.tidy
    }
    
    init(from viewModel: NewProductViewModel) {
        assert(!viewModel.isInvalid, "The view model contains an invalid product")
        
        self.id = UUID().uuidString
        self.name = viewModel.name
        self.category = viewModel.category ?? .defaultCategory
        self.color = viewModel.color.description
        self.price = viewModel.price
        self.rating = 5
        self.currentInventory = viewModel.currentInventory
        self.inventoryTracking = viewModel.inventoryTracking
        self.lowInventoryNotification = viewModel.lowInventoryNotification
        self.barcode = viewModel.barcode.isEmpty ? nil : viewModel.barcode
    }
    
    /// Tells whether the product's properties are all valid values.
    /// - Returns: Bool
    /// 
    func isValid() -> Bool {
        return !self.id.isEmpty && !self.name.tidy.isEmpty && self.price > 0 && self.rating >= 0 && self.rating <= 5
    }
    
    func getPrice() -> Float {
        return self.price
    }
    
    func updateCategory() {
        
    }
    
    func updateColor(newColor: String) {
        
    }
    
    /// Updates the current price of a Product.
    /// - Parameter newPrice: Float > 0
    /// - Returns: The last price of the product.
    mutating func setPrice(_ newPrice: Float) -> Float {
        let oldPrice = self.getPrice()
        
        guard newPrice > 0 else {
            print("newPrice must be > 0")
            return oldPrice
        }
        
        self.price = newPrice
        return oldPrice
    }
    
}
