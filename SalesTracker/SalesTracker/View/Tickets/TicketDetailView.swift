//
//  TicketDetailView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/06/24.
//

import SwiftUI

struct TicketDetailView: View {
    let ticket: Ticket
    private let currencyCode: String = Locale.current.currency?.identifier ?? "USD"
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
    #else
    private let isCompact = false
    #endif
    
    var body: some View {
        if self.isCompact { 
            // iPhone View
            // Display the information in a simple grid
            ScrollView {
                ProductsGridView
            }
        } else {
            // iPad and Mac Views
            // Display the information in a table
            ProductsTableView
        }
    }
    
    #warning("Add a totals row")
    private var ProductsTableView: some View {
        Table(ticket.productsSummary) {
            TableColumn("product", value: \.product.name)
            TableColumn("count") { summary in
                Text(summary.count, format: .number)
            }
            TableColumn("price") { summary in
                Text(summary.product.getPrice(), format: .currency(code: currencyCode))
            }
            TableColumn("total") { summary in
                Text(summary.totalPrice, format: .currency(code: currencyCode))
            }
        }
    }
    private var ProductsGridView: some View {
        Grid {
            // Headers
            GridRow {
                Text("product")
                Text("count")
                Text("price")
                Text("total")
            }
            .fontWeight(.semibold)
            
            // Products information
            ForEach(ticket.productsSummary) { summary in
                GridRow {
                    Text(summary.product.name)
                        .gridColumnAlignment(.leading)
                    Text(summary.count, format: .number)
                    Text(summary.product.getPrice(), format: .currency(code: currencyCode))
                    Text(summary.totalPrice, format: .currency(code: currencyCode))
                }
                Divider()
            }
            
            // Totals
            GridRow {
                Text("total")
                    .fontWeight(.semibold)
                Text(ticket.productCount, format: .number)
                    .gridColumnAlignment(.trailing)
                    .gridCellColumns(2)
                Text(ticket.totalCharge, format: .currency(code: currencyCode))
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal)
    }
}
