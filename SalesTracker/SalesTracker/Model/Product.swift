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
    
    private var price: Float
    
    init() {
        self.id = UUID().uuidString
        self.name = "Product name"
        self.category = "default"
        self.color = .green
        self.price = 0
    }
    
    init(name: String, category: String, color: Color, price: Float) {
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.color = color
        self.price = price
    }
    
    func updateCategory() {
        
    }
    
    func updateColor(newColor: String) {
        
    }
    
    func updatePrice(newPrice: Float) {
        
    }
    
    func getPrice() -> Float {
        return self.price
    }
    
    func updatePrice(to newPrice: Float) -> Float {
        let oldPrice = self.price
        self.price = newPrice
        // Methods to update price information
        // in Data Model.
        return oldPrice
    }
    
    
}
