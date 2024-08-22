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
  
  func getAllProducts() async throws {
    self.products = try await ProductsManager.shared.getAllProducts()
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
      try? await viewModel.getAllProducts()
    }
    .navigationTitle("Products")
  }
}

#Preview {
  ProductsView()
}
