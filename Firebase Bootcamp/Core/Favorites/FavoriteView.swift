//
//  FavoriteView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 02.09.2024.
//

import SwiftUI

struct FavoriteView: View {
  
  @StateObject private var viewModel = FavoriteViewModel()
  
  var body: some View {
    List {
      ForEach(viewModel.userFavoriteProducts, id: \.id.self) { item in
        ProductCellViewBuilder(productId: String(item.productId))
          .contextMenu(menuItems: {
            Button("Remove from  favorites") {
              viewModel.removeFromFavorites(favoriteProductId: item.id)
            }
          })
      }
    }
    .navigationTitle("Favorites")
    .onFirstAppear {
      viewModel.addListenerForFavorites()
    }
  }
}

#Preview {
  NavigationStack {
    FavoriteView()
  }
}

