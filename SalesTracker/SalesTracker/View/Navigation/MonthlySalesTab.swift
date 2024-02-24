//
//  MonthlySalesTab.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 24/02/24.
//

import SwiftUI

struct MonthlySalesTab: View {
    @ObservedObject var salesModel: SalesModel
    var body: some View {
        NavigationStack {
            MonthlySales(salesModel: self.salesModel)
                .navigationTitle("monthly_sales")
        }
    }
}

#Preview {
    MonthlySalesTab(salesModel: SalesModel())
}
