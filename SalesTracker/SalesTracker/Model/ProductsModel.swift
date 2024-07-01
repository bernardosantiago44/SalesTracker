//
//  ProductsModel.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class ProductsModel: ObservableObject {
    @Published var Products = [Product]()
    @Published var categories = [ProductCategory]()
    @Published var sampleProducts: [Product] = Product.SampleProducts
    
    @Published var errorMessage: String? 
    @Published var showErrorMessage = false
    @Published var actionResponse: ActionReponse? {
        didSet {
            if actionResponse == .Successful {
                actionResponse = nil
            }
        }
    }
    
    var intialFetchPending = true
    
    private var db = Firestore.firestore()
    
    // MARK: - Products methods
    func addProductToCatalog(_ product: Product) {
        // Check if product contains all essential elements.
        guard product.isValid() else {
            self.showErrorMessage = true
            self.errorMessage = "invalid_product_fields"
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            userNeedsToAuthenticate()
            return
        }
        
        self.actionResponse = .InProgress
        self.Products.append(product)
        do {
            try db.collection("users/\(user.uid)/products").document(product.id).setData(from: product)
            self.actionResponse = .Successful
            print("Successfully added \(product.name) to database.")
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorMessage = true
            self.actionResponse = .Unsuccessful
            return
        }
        self.actionResponse = .Successful
    }
    
    func fetchProducts() async {
        guard let user = Auth.auth().currentUser else {
            // Let the user know that they'll have to re-authenticate
            self.userNeedsToAuthenticate()
            return
        }
        
        self.actionResponse = .InProgress
        do {
            let documentsQuery = try await db.collection("users/\(user.uid)/products").limit(to: 10).getDocuments()
            self.Products.removeAll()
            for document in documentsQuery.documents {
                let documentData = try document.data(as: Product.self)
                self.Products.append(documentData)
            }
        } catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            self.showErrorMessage = true
            return
        }
        self.actionResponse = .Successful
    }
    
    func deleteProductFromCatalog(productId: String) async {
        guard let user = Auth.auth().currentUser else {
            userNeedsToAuthenticate()
            return
        }
        self.actionResponse = .InProgress
        print("Deleting product")
        do {
            try await db.collection("users/\(user.uid)/products").document(productId).delete()
            self.Products.removeAll(where: { $0.id == productId })
            print("Document successfully deleted")
        } catch {
            print(error.localizedDescription)
            self.showErrorMessage = true
            self.errorMessage = error.localizedDescription
            return
        }
        self.actionResponse = .Successful
    }
    
    // MARK: - Categories methods
    /// A method which adds a ProductCategory to the current SalesModel
    /// and to the Firestore Database.
    /// 
    func registerCategory(_ category: ProductCategory) {
        if self.categories.contains(where: { $0 == category }) {
            return
        }
        
        guard category.isValid() else {
            self.showErrorMessage = true
            self.errorMessage = "invalid_category_fields"
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            self.userNeedsToAuthenticate()
            return
        }
        
        self.actionResponse = .InProgress
        self.categories.append(category)
        do {
            try db.collection("users/\(user.uid)/categories").document(category.id).setData(from: category)
        } catch {
            self.showErrorMessage = true
            self.errorMessage = error.localizedDescription
            return
        }
        self.actionResponse = .Successful
    }
    
    func fetchCategories() async {
        
        guard let user = Auth.auth().currentUser else {
            self.userNeedsToAuthenticate()
            return
        }
        self.actionResponse = .InProgress
        
        do {
            let categoriesQuery = try await db.collection("users/\(user.uid)/categories").limit(to: 20).getDocuments()
            self.categories.removeAll()
            for document in categoriesQuery.documents {
                let documentCategoryData = try document.data(as: ProductCategory.self)
                self.categories.append(documentCategoryData)
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorMessage = true
            return
        }
        self.actionResponse = .Successful
    }
    
    // MARK: - Other methods
    func raiseError() {
        self.showErrorMessage = true
        self.errorMessage = "This is a test error."
    }
    
    /// Method to let the user know that authentication is required.
    ///
    private func userNeedsToAuthenticate() {
        self.errorMessage = URLError(.userAuthenticationRequired).localizedDescription
        self.showErrorMessage = true
    }
}
