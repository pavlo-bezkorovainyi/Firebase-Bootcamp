//
//  SettingsView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
  
  @Published var authProviders: [AuthProviderOption] = []
  
  func loadAuthProviders() {
    if let providers = try? AuthenticationManager.shared.getProviders() {
      authProviders = providers
    }
  }
  
  func signOut() throws {
    try AuthenticationManager.shared.signOut()
  }
  
  func resetPassword() async throws {
    let authUser = try  AuthenticationManager.shared.getAuthenticatedUser()
    
    guard let email = authUser.email else {
      throw URLError(.fileDoesNotExist)
    }
    
    try await AuthenticationManager.shared.resetPassword(email: email)
  }
  
  func updateEmail() async throws {
    let email = "hello123@gmail.com"
    try await AuthenticationManager.shared.updateEmail(email: email)
  }
  
  func updatePassword() async throws {
    let password = "Hello123!"
    try await AuthenticationManager.shared.updatePassword(password: password)
  }
}

struct SettingsView: View {
  
  @StateObject private var viewModel = SettingsViewModel()
  @Binding var showSignInView: Bool
  
  var body: some View {
    List {
      Button("Log Out") {
        Task {
          do {
            try viewModel.signOut()
            showSignInView = true
          } catch {
            print(error)
          }
        }
      }
      
      if viewModel.authProviders.contains(.email) {
        emailSection
      }
      
    }
    .onAppear() {
      viewModel.loadAuthProviders()
    }
    .navigationTitle("Settings")
  }
}

#Preview {
  NavigationStack {
    SettingsView(showSignInView: .constant(false))
  }
}

extension SettingsView {
  
  private var emailSection: some View {
    Section {
      Button("Reset password") {
        Task {
          do {
            try await viewModel.resetPassword()
            print("PASSWORD RESET!")
          } catch {
            print(error)
          }
        }
      }
      
      Button("Update password") {
        Task {
          do {
            try await viewModel.updatePassword()
            print("PASSWORD UPDATED!")
          } catch {
            print(error)
          }
        }
      }
      
      Button("Update email") {
        Task {
          do {
            try await viewModel.updateEmail()
            print("EMAIL UPDATED!")
          } catch {
            print(error)
          }
        }
      }
    } header: {
      Text("Email functions")
    }
  }
}
