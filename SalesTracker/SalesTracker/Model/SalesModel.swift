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
    var totalSales: UInt = 0
    
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
        totalSales = 0
        let relativeReference = date.relativeReference
        guard let daysInMonthUntilToday = date.daysInMonthUntilToday else { throw URLError(.unknown) }
        var salesInfo: [SalesData] = []
        var salesDict: [String: UInt] = [:]
        
//        sales.removeAll()
        let salesDocument = db.collection("sales").document(relativeReference)
        for day in daysInMonthUntilToday {
            let currentDate = DateComponents(calendar: .current, year: date.get(.year), month: date.get(.month), day: day).date!
            let query = try await salesDocument.collection(currentDate.absoluteReference).order(by: "count", descending: true).getDocuments()
            if query.isEmpty { continue }
            for document in query.documents {
                let data    = try document.data(as: ProductSaleDescriptor.self)
                let product = try await data.product.getDocument().data(as: Product.self)
                let oldValue = salesDict[product.name] ?? 0
                #warning("Try optimizing with default in dictionary")
                // salesDict[product.name, default: 0] += data.count
                salesDict[product.name] = data.count + oldValue
                totalSales += data.count
            }
        }
        salesInfo = salesDict.map { (key: String, value: UInt) in
            SalesData(product: key, count: value)
        }
        
        return salesInfo.sorted(by: { $0.count > $1.count })
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

extension SalesData {
    static let sampleData = [
        SalesData(product: "Product 1", count: 15),
        SalesData(product: "Product 2", count: 9),
        SalesData(product: "Product 3", count: 12),
        SalesData(product: "Product 3", count: 14)
    ]
}
