//
//  ProductCategory.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 11/01/24.
//

import Foundation

struct ProductCategory: Codable, Equatable, Identifiable, Hashable {
    static func == (lhs: ProductCategory, rhs: ProductCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var categoryName: String
    
    init(id: String = UUID().uuidString, category: String) {
        assert(!category.tidy.isEmpty, "Category name can't be empty")
        
        self.id = id
        self.categoryName = category
    }
    
    func isValid() -> Bool {
        return !self.categoryName.isEmpty && !self.id.isEmpty
    }
}

extension ProductCategory {
    static let defaultCategory = ProductCategory(id: "e794ed8f-f550-433a-861f-4abadea5a25c", category: "default")
    static let dessert = ProductCategory(id: "d492b196-40e5-4b61-8d02-a0d145f29ece", category: "dessert")
    static let light = ProductCategory(id: "a857fe07-0e5a-4a55-8884-e78cc36f249f", category: "light")
}
