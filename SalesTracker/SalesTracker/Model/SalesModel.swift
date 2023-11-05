//
//  Shared.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import Foundation

final class SalesModel: ObservableObject {
    @Published var Products = [Product]()
    @Published var sampleProducts: [Product] = Product.SampleProducts
    
    func addProductToCatalog(_ product: Product) -> ActionReponse {
        // Check if product contains all essential elements. 
        guard product.isValid() else { return .Unsuccessful }
        
        self.Products.append(product)
        return .Successful
    }
}
