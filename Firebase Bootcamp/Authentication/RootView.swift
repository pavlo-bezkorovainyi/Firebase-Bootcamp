//
//  RootView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI

struct RootView: View {
  
  @State private var showSignedInView: Bool = false
  
  var body: some View {
    ZStack {
      NavigationStack {
        SettingsView(showSignInView: $showSignedInView)
      }
    }
    .onAppear {
      let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
      self.showSignedInView = authUser == nil
    }
    .fullScreenCover(isPresented: $showSignedInView, content: {
      NavigationStack {
        AuthenticationView(showSignedInView: $showSignedInView)
      }
    })
  }
}

#Preview {
  RootView()
}
