//
//  ProductViewModel.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 04.09.2024.
//

import SwiftUI
import FirebaseFirestore

@MainActor
final class ProductsViewModel: ObservableObject {
  
  @Published private(set) var products: [Product] = []
  @Published var selectedFilter: FilterOption?
  @Published var selectedCategory: CategoryOption?
  private var lastDocument: DocumentSnapshot?
  
  enum FilterOption: String, CaseIterable {
    case noFilter
    case priceHigh
    case priceLow
    
    var priceDescending: Bool? {
      switch self {
      case .noFilter: nil
      case .priceHigh: true
      case .priceLow: false
      }
    }
  }
  
  func filterSelected(option: FilterOption) async throws {
    self.selectedFilter = option
    self.products = []
    self.lastDocument = nil
    self.getProducts()
  }
  
  enum CategoryOption: String, CaseIterable {
    case noCategory
    case furniture
    case beauty
    case fragrances
    
    var categorykey: String? {
      self == .noCategory ? nil : rawValue
    }
  }
  
  func categorySelected(option: CategoryOption) async throws {
    self.selectedCategory = option
    self.products = []
    self.lastDocument = nil
    self.getProducts()
  }
  
  func getProducts() {
    Task {
      let (newProducts, lastDocument) = try await ProductsManager.shared.getAllProducts(priceDescending: selectedFilter?.priceDescending, forCategory: selectedCategory?.categorykey, count: 10, lastDocument: lastDocument)
      self.products.append(contentsOf: newProducts)
      if let lastDocument {
        self.lastDocument = lastDocument
      }
      
    }
  }
  
  func addUserFavoriteProduct(productId: Int) {
    Task {
      let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
      try? await UserManager.shared.addUserFavoriteProduct(userId: authDataResult.uid, productId: productId)
    }
  }
  
//  func getProductsCount() {
//    Task {
//      let count = try await ProductsManager.shared.getAllProductsCount()
//      print("ALL PRODUCT COUNT: \(count)")
//    }
//  }
  
  //  func getProductsByRating() {
  //    Task {
  //      let (newProducts, lastDocument) = try await ProductsManager.shared.getProductsByRating(count: 3, lastDocument: lastDocument)
  //      self.products.append(contentsOf: newProducts)
  //      self.lastDocument = lastDocument
  //    }
  //  }
}
