//
//  ProductsViewModel.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 29/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable class ProductsViewModel {
    var products: [Product] = []
    var categories: [ProductCategory] = []
    var filterCategorySelection: ProductCategory?
    
    var showErrorAlert = false
    var isBusy = false
    var error: Error?
    var showNewProductSheet = false
    
    @ObservationIgnored var initialFetchPending = true
    
    @ObservationIgnored private var db = Firestore.firestore()
    
    // MARK: - Products
    private func fetchProductsFromDb() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let documentsQuery = try await db.collection("users/\(user.uid)/products").getDocuments()
        self.products.removeAll()
        if documentsQuery.isEmpty {
            self.isBusy = false
            return
        }
        
        for doc in documentsQuery.documents {
            let product = try doc.data(as: Product.self)
            self.products.append(product)
        }
    }
    
    /// Validates data and posts the provided product
    /// to the firestore database.
    /// Throws: URLError
    ///
    private func addProductToDb(_ product: Product) throws {
        // Check if product contains all necessary data
        guard product.isValid() else {
            throw URLError(.cannotCreateFile)
        }
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        // Try to post product to database first to avoid duplicated
        try db.collection("users/\(user.uid)/products").document(product.id).setData(from: product)
        self.products.append(product)
    }
    
    /// Use this function to add a product to the database and
    /// handle errors.
    ///
    public func addProduct(_ product: Product) {
        self.isBusy = true
        do {
            try self.addProductToDb(product)
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
        self.isBusy = false
    }
    
    public func downloadProducts() async {
        self.isBusy = true
        do {
            try await self.fetchProductsFromDb()
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
        self.isBusy = false
    }
    
    // MARK: - Categories
    /// A method which adds a ProductCategory to the current view model
    /// and to the Firestore Database.
    /// throws: URLError
    ///
    private func registerCategory(_ category: ProductCategory) throws {
        if self.categories.contains(where: { $0.categoryName == category.categoryName }) {
            return
        }
        
        guard category.isValid() else {
            throw URLError(.cannotCreateFile)
        }
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        // First, attempt to write to database
        // to avoid duplicate data
        try db.collection("users/\(user.uid)/categories").document(category.id).setData(from: category)
        self.categories.append(category)
    }
    
    /// Downloads the categories from the firestore database.
    /// Throws: URLError
    ///
    private func fetchCategories() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let categoriesQuery = try await db.collection("users/\(user.uid)/categories").limit(to: 10).getDocuments()
        self.categories.removeAll()
        for change in categoriesQuery.documentChanges {
            let category = try change.document.data(as: ProductCategory.self)
            self.categories.append(category)
        }
    }
    
    public func downloadCategories() async {
        self.isBusy = true
        do {
            try await self.fetchCategories()
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
        self.isBusy = false
    }
    
    /// Use this function to add a category to the database and
    /// handle the errors.
    ///
    public func createCategory(_ category: ProductCategory) {
        self.isBusy = true
        do {
            try self.registerCategory(category)
        } catch {
            self.error = error
            self.showErrorAlert = true
        }
        self.isBusy = false
    }
}
