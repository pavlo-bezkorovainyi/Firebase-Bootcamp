//
//  ProductView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 22.08.2024.
//

import SwiftUI

@MainActor
final class ProductsViewModel: ObservableObject {
  
  @Published private(set) var products: [Product] = []
  @Published var selectedFilter: FilterOption?
  @Published var selectedCategory: CategoryOption?
  
//  func getAllProducts() async throws {
//    self.products = try await ProductsManager.shared.getAllProducts(priceDescending: <#Bool?#>, forCategory: <#String?#>)
//  }
  
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
    try await self.getProducts()
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
    try await self.getProducts()
  }
  
  func getProducts() async throws {
    self.products = try await ProductsManager.shared.getAllProducts(priceDescending: selectedFilter?.priceDescending, forCategory: selectedCategory?.categorykey)
  }
}

struct ProductsView: View {
  
  @StateObject private var viewModel = ProductsViewModel()
  
  var body: some View {
    List {
      ForEach(viewModel.products) { product in
        ProductCellView(product: product)
      }
    }
    .task {
      try? await viewModel.getProducts()
    }
    .navigationTitle("Products")
    .toolbar(content: {
      ToolbarItem(placement: .navigationBarLeading) {
        Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "NONE")") {
          ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { option in
            Button(option.rawValue) {
              Task {
                try? await viewModel.filterSelected(option: option)
              }
            }
          }
        }
      }
      
      ToolbarItem(placement: .navigationBarTrailing) {
        Menu("Category: \(viewModel.selectedCategory?.rawValue ?? "NONE")") {
          ForEach(ProductsViewModel.CategoryOption.allCases, id: \.self) { option in
            Button(option.rawValue) {
              Task {
                try? await viewModel.categorySelected(option: option)
              }
            }
          }
        }
      }
    })
  }
}

#Preview {
  NavigationStack {
    ProductsView()
  }
}
