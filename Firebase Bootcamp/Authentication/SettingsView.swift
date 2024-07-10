//
//  SettingsView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
  
  func signOut() throws {
    try AuthenticationManager.shared.signOut()
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
    }
    .navigationTitle("Settings")
  }
}

#Preview {
  NavigationStack {
    SettingsView(showSignInView: .constant(false))
  }
}
