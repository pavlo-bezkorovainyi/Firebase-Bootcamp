//
//  SignInEmailView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI

final class SignInEmailViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  
  func signUp() async throws {
    guard !email.isEmpty, !password.isEmpty else {
      print("No email or password found.")
      return
    }
    
    try await AuthenticationManager.shared.createUser(email: email, password: password)
  }
  
  func signIn() async throws {
    guard !email.isEmpty, !password.isEmpty else {
      print("No email or password found.")
      return
    }
    
    try await AuthenticationManager.shared.signInUser(email: email, password: password)
  }
}

struct SignInEmailView: View {
  
  @StateObject private var viewModel = SignInEmailViewModel()
  @Binding var showSignedInView: Bool
  
  var body: some View {
    VStack {
      TextField("Email...", text: $viewModel.email)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(10)
      
      SecureField("Password...", text: $viewModel.password)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(10)
      
      Button(action: {
        Task {
          do {
            try await viewModel.signUp()
            showSignedInView = false
            return
          } catch {
            print(error)
          }
          
          do {
            try await viewModel.signIn()
            showSignedInView = false
            return
          } catch {
            print(error)
          }
        }
      }, label: {
        Text("Sign In")
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
      })
      
      Spacer()
    }
    .padding()
    .navigationTitle("Sign In With Email")
  }
}

#Preview {
  NavigationStack {
    SignInEmailView(showSignedInView: .constant(false))
  }
}
