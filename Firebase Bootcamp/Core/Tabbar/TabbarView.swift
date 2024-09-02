//
//  TabbarView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 02.09.2024.
//

import SwiftUI

struct TabbarView: View {
  
  @Binding var showSignInView: Bool
  
  var body: some View {
    TabView {
      NavigationStack {
        ProductsView()
      }
      .tabItem {
        Image(systemName: "cart")
        Text("Products")
      }
      
      NavigationStack {
        FavoriteView()
      }
      .tabItem {
        Image(systemName: "star.fill")
        Text("Favorites")
      }
      
      NavigationStack {
        ProfileView(showSignInView: $showSignInView)
      }
      .tabItem {
        Image(systemName: "person")
        Text("Profile")
      }
      
      
    }
  }
}

#Preview {
  TabbarView(showSignInView: .constant(false))
}
