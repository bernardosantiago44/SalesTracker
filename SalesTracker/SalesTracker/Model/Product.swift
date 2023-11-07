//
//  Product.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import Foundation
import SwiftUI

// Creating a class to save data through
// Swift Data
//
class Product: Identifiable {
    var id: String
    
    var name: String
    
    var category: String
    
    var color: Color
    
    var rating: Float
    
    private var price: Float
    
    init() {
        self.id = UUID().uuidString
        self.name = "Product name"
        self.category = "default"
        self.color = .green
        self.price = 1
        self.rating = 5
    }
    
    init(name: String, category: String, color: Color, price: Float, rating: Float) {
        assert(!name.isEmpty, "Name can't be empty")
        assert(price > 0, "Price must be > 0.")
        assert(rating >= 0 && rating <= 5, "Rating must be between 0 and 5.")
        
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.color = color
        self.price = price
        self.rating = rating
    }
    
    /// Tells whether the product's properties are all valid values.
    /// - Returns: Bool
    /// 
    func isValid() -> Bool {
        return !self.id.isEmpty && !self.name.isEmpty && self.price > 0
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
    func setPrice(_ newPrice: Float) -> Float {
        let oldPrice = self.getPrice()
        
        guard newPrice > 0 else {
            print("newPrice must be > 0")
            return oldPrice
        }
        
        self.price = newPrice
        return oldPrice
    }
    
}
