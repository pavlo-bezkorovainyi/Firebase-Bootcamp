//
//  AuthenticationView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor final class AuthenticationVieModel: ObservableObject {
  
  func signInGoogle() async throws {
    let helper = SignInGoogleHelper()
    let tokens = try await helper.signIn()
    try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
  }
}

struct AuthenticationView: View {
  
  @StateObject private var viewModel = AuthenticationVieModel()
  @Binding var showSignedInView: Bool
  
  var body: some View {
    VStack {
      NavigationLink {
        SignInEmailView(showSignedInView: $showSignedInView)
      } label: {
        Text("Sign In With Email")
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
        
      }
      
      GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
        Task {
          do {
            try await viewModel.signInGoogle()
            showSignedInView = false
          } catch {
            print(error)
          }
        }
      }
      
      Spacer()
    }
    .padding()
    .navigationTitle("Sign In")
  }
}

#Preview {
  NavigationStack {
    AuthenticationView(showSignedInView: .constant(false))
  }
}
