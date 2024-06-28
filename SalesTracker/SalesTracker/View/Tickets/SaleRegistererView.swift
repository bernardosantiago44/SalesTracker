//
//  SaleRegistererView.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 28/06/24.
//

import SwiftUI

struct SaleRegistererView: View {
    @State private var ticketViewModel = NewTicketViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            Section {
                TextField("productKey", text: $ticketViewModel.productKey)
                    .textFieldStyle(RoundedGroupTextFieldStyle())
                    .padding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Text("cancel")
                }
            }
        }
    }
}

#Preview {
    SaleRegistererView()
}
