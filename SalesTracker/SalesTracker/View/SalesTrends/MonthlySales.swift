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
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            if !salesModel.sales.isEmpty {
                monthlyProductSales
            } 
            HStack {Spacer()}
        }
        .overlay {
            if salesModel.sales.isEmpty {
                ContentUnavailableView {
                    Label("no_data", systemImage: "chart.bar")
                } description: {
                    Text("add_records_description")
                } actions: {
                    Button {
                        Task {
                            do {
                                self.inProgress = true
                                salesModel.sales = try await salesModel.fetchMontlySales(for: Date.now)
                            } catch {
                                self.showAlert = true
                                self.alertMessage = error.localizedDescription
                            }
                            self.inProgress = false
                        }
                    } label: {
                        if self.inProgress {
                            ProgressView()
                        } else {
                            Text("refresh")
                        }
                    }
                }
            }
        }
        .alert("error", isPresented: $showAlert) {
            
        } message: {
            Text(alertMessage)
        }

    }
    
    var ProductTrendSalesTitle: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("product_trends")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text("\(salesModel.totalSales) ")
                    .font(.title3)
                + Text("total_sales")
            }
            Spacer()
        }
    }
    
    var monthlyProductSales: some View {
        GroupBox {
            ProductTrendSalesTitle
            Chart(salesModel.sales) { sale in
                BarMark(
                    x: .value("Product sales", sale.count),
                    y: .value("Product type", sale.product + ": \(sale.count)")
                )
                
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(height: 300)
        .padding(.horizontal)
    }
}

#Preview {
    MonthlySalesTab(salesModel: SalesModel())
}
