//
//  AuthenticationView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI

struct AuthenticationView: View {
  var body: some View {
    VStack {
      NavigationLink {
        SignInEmailView()
      } label: {
        Text("Sign In With Email")
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
        
      }
      
      Spacer()
    }
    .padding()
    .navigationTitle("Sign In")
  }
}

#Preview {
  NavigationStack {
    AuthenticationView()
  }
}
