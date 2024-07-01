//
//  CategoryPicker.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 05/01/24.
//

import SwiftUI

struct CategoryPicker: View {
    @Bindable var salesModel: ProductsViewModel
    @Binding var selection: ProductCategory?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
//                ForEach(sampleCategories, id: \.self) { category in
                ForEach(self.salesModel.categories) { category in
                    Text(category.categoryName)
                        .foregroundStyle(selection == category ? .white : .primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(selection == category ? .blue : Color(uiColor: .secondarySystemBackground), in: Capsule())
                        .onTapGesture {
                            if self.selection == category {
                                self.selection = nil
                            } else {
                                self.selection = category
                            }
                        }
                        .animation(.smooth, value: selection)
                }
            }
        }
    }
    
    var sampleCategories: [ProductCategory] = [.defaultCategory, .dessert, .light]
}

#Preview {
    CategoryPicker(salesModel: ProductsViewModel(), selection: .constant(.dessert))
}
