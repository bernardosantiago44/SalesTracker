//
//  Ticket.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Ticket: Identifiable, Codable, Hashable {
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        lhs.id == rhs.id
    }
    
    @DocumentID var id: String?
    var date: Date
    var productsReference: [ProductCounter]
    var productsSummary: [ProductSummary] = []
    
    var productCount: Int {
        productsSummary.reduce(0, { $0 + $1.count })
    }
    var totalCharge: Float {
        productsSummary.reduce(Float(0), { $0 + $1.totalPrice })
    }
    
    enum CodingKeys: String, CodingKey {
        case productsReference = "products"
        case date = "date"
    }
}

struct ProductCounter: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var count: Int
    var product: DocumentReference
}

struct ProductSummary: Hashable, Identifiable {
    var id: String {
        product.id
    }
    var count: Int
    var product: Product
    var totalPrice: Float {
        product.getPrice() * Float(count)
    }
}
