//
//  TicketsList.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/06/24.
//

import SwiftUI

struct TicketsList: View {
    @Bindable var viewModel: TicketsViewModel
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
    TicketsList(viewModel: TicketsViewModel())
}
