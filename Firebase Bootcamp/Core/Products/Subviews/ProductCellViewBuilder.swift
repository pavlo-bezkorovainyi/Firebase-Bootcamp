//
//  ProductCellViewBuilder.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 02.09.2024.
//

import SwiftUI

struct ProductCellViewBuilder: View {
  
  let productId: String
  @State private var product: Product?
  
    var body: some View {
      ZStack {
        if let product {
          ProductCellView(product: product)
        }
      }
      .task {
        self.product = try? await ProductsManager.shared.getProduct(productId: self.productId)
      }
    }
}

#Preview {
    ProductCellViewBuilder(productId: "1")
}
