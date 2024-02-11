//
//  MonthlySales.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 07/02/24.
//

import SwiftUI
import Charts

struct MonthlySales: View {
    @ObservedObject var salesModel: SalesModel
    @State private var inProgress = false
    
    var body: some View {
        ScrollView {
            Text("Total Sales: \(salesModel.sales.reduce(0, { $0 + Int($1.count) }))")
                .font(.title)
                .fontDesign(.rounded)
                .fontWeight(.medium)
            GroupBox {
                if salesModel.sales.isEmpty {
                    ContentUnavailableView(label: {
                        Label("no_data", systemImage: "questionmark.diamond.fill")
                    }, description: {
                        Text("add_records_description")
                    })
                } else {
                    Chart {
                        ForEach(salesModel.sales.prefix(5)) { sale in
                            BarMark(
                                x: .value("Product type", sale.product),
                                y: .value("Product sales", sale.count)
                            )
                            .annotation {
                                Text("\(sale.count)")
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(height: 250)
            
            Button {
                Task {
                    do {
                        self.inProgress = true
                        salesModel.sales = try await salesModel.fetchMontlySales(for: Date.now)
                        self.inProgress = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                if self.inProgress {
                    ProgressView()
                } else {
                    Text("refresh")
                }
            }
        }
        .navigationTitle("monthly_sales")
    }
}

#Preview {
    NavigationStack {
        MonthlySales(salesModel: SalesModel())
    }
}
