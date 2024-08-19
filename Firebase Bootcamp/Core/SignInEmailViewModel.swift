//
//  SignInEmailViewModel.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 19.08.2024.
//

import Foundation

final class SignInEmailViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  
  func signUp() async throws {
    guard !email.isEmpty, !password.isEmpty else {
      print("No email or password found.")
      return
    }
    
    let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
    try await UserManager.shared.createNewUser(auth: authDataResult)
  }
  
  func signIn() async throws {
    guard !email.isEmpty, !password.isEmpty else {
      print("No email or password found.")
      return
    }
    
    try await AuthenticationManager.shared.signInUser(email: email, password: password)
  }
}
