//
//  TicketsViewModel.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable class TicketsViewModel {
    var tickets: [Ticket] = []
    
    @ObservationIgnored private var db = Firestore.firestore()
    
    /// Retrieves the last specified number of tickets in the database.
    /// Errors must be handled when calling the function.
    /// - Parameter maximum: The number of tickets to be retrieved, default to 20
    ///
    public func fetchTickets(maximum: Int = 20) async throws {
        // Check if the user is authenticated
        guard Auth.auth().currentUser != nil else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let ticketsQuerySnapshot = try await db.collection("tickets").getDocuments()
        var readTickets: [Ticket] = []
            
        for document in ticketsQuerySnapshot.documents {
            var ticket = try document.data(as: Ticket.self)
            
            // Decode the reference as a product
            #warning("Switch to a task group and fetch documents simultaniously")
            for productCounter in ticket.productsReference {
                // First decode the product reference and instantiate it
                let product = try await productCounter.product.getDocument().data(as: Product.self)
                
                // Then, create a product totalizer instance with the data of the counter
                // and the product itself
                ticket.productsSummary.append(ProductSummary(count: productCounter.count, product: product))
            }
            readTickets.append(ticket)
        }
        self.tickets.removeAll()
        self.tickets = readTickets
    }
}
