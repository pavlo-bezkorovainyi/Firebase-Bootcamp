//
//  ProductView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 22.08.2024.
//

import SwiftUI

struct ProductsView: View {
  
  @StateObject private var viewModel = ProductsViewModel()
  
  var body: some View {
    List {
      ForEach(viewModel.products) { product in
        ProductCellView(product: product)
          .contextMenu(menuItems: {
            Button("Add to favorites") {
              viewModel.addUserFavoriteProduct(productId: product.id)
            }
          })
        
        if product == viewModel.products.last {
          ProgressView()
            .onAppear {
              print("fetching more products")
              viewModel.getProducts()
              
            }
        }
      }
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
    .onAppear {
      viewModel.getProducts()
    }
  }
}

#Preview {
  NavigationStack {
    ProductsView()
  }
}
