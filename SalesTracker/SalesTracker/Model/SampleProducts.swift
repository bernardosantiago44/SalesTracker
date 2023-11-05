//
//  SampleProducts.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/23.
//

import Foundation
import SwiftUI

extension Product {
    static var SampleProducts: [Product] {[
        Product(name: "Ice-cream", category: "dessert", color: .yellow, price: 95),
        Product(name: "Yogurt Ice-cream", category: "dessert", color: .orange, price: 105),
        Product(name: "Salad", category: "light", color: .green, price: 85),
        Product(name: "Ensalada Cesar", category: "light", color: .mint, price: 110)
    ]}
}
