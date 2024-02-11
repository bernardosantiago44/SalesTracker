//
//  SalesModel.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 06/02/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class SalesModel: ObservableObject {
    @Published var currentMonthSales = ""
    @Published var sales: [SalesData] = []
    
    var currentMonthPath: String {
        return Date.now.relativeReference
    }
    
    private var db = Firestore.firestore()
    
    // MARK: - Sales methods
    /// Retrieves the monthly sales of the specified date.
    /// - Parameter for: Date
    func fetchMontlySales(for date: Date = .now) async throws -> [SalesData] {
        guard Auth.auth().currentUser != nil else {
            throw URLError(.userAuthenticationRequired)
        }
        let relativeReference = date.relativeReference
        guard let daysInMonthUntilToday = date.daysInMonthUntilToday else { throw URLError(.unknown) }
        var salesInfo: [SalesData] = []
        
//        sales.removeAll()
        let salesDocument = db.collection("sales").document(relativeReference)
        for day in daysInMonthUntilToday {
            let currentDate = DateComponents(calendar: .current, year: date.get(.year), month: date.get(.month), day: day).date!
            let query = try await salesDocument.collection(currentDate.absoluteReference).order(by: "count", descending: true).getDocuments()
            for document in query.documents {
                let data    = try document.data(as: ProductSaleDescriptor.self)
                let product = try await data.product.getDocument().data(as: Product.self)
                salesInfo.append(SalesData(product: product.name, count: data.count))
            }
        }
        return salesInfo
    }
    
    func fetchMontlySales() {
        
    }
}

struct ProductSaleDescriptor: Codable, Identifiable {
    @DocumentID
    var id: String?
    
    var product: DocumentReference
    var count: UInt
}

struct SalesData: Identifiable, Codable {
    var id: String = UUID().uuidString
    var product: String
    var count: UInt
}
