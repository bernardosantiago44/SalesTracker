//
//  TicketsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/06/24.
//

import SwiftUI

struct TicketsList: View {
    @Bindable var viewModel: TicketsListViewModel
    var body: some View {
        Group {
            if viewModel.tickets.isEmpty {
                ContentUnavailableView {
                    Label("no_tickets", systemImage: "folder.badge.questionmark")
                } description: {
                    Text("add_tickets_description")
                } actions: {
                    Button("reload") {
                        Task {
                            await fetchTickets()
                        }
                    }
                }

            } else {
                List(viewModel.tickets) { ticket in
                    VStack {
                        NavigationLink(value: ticket) {
#warning("fix this")
                            Text(ticket.date, style: .date) + Text(ticket.date, style: .time)
                        }
                    }
                }
                .navigationDestination(for: Ticket.self) { ticket in
                    TicketDetailView(ticket: ticket)
                }
            }
        }
        .navigationTitle("tickets")
        .refreshable {
            do {
                try await viewModel.fetchTickets()
            } catch {
                print(error.localizedDescription)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                newSaleButton
            }
        }
        .fullScreenCover(isPresented: $viewModel.newSaleSheetPresented) {
            NavigationStack {
                SaleRegistererView()
            }
        }
    }
    
    private var newSaleButton: some View {
        Button {
            self.viewModel.newSaleSheetPresented = true
        } label: {
            Image(systemName: "plus.circle.fill")
        }
        .font(.title3)
    }
    
    private func fetchTickets() async {
        do {
            try await viewModel.fetchTickets()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    TicketsList(viewModel: TicketsListViewModel())
}
