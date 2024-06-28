//
//  TicketsTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/06/24.
//

import SwiftUI

struct TicketsTab: View {
    @Bindable var ticketsViewModel: TicketsListViewModel
    var body: some View {
        NavigationStack {
            TicketsList(viewModel: self.ticketsViewModel)
        }
    }
}

#Preview {
    TicketsTab(ticketsViewModel: TicketsListViewModel())
}
