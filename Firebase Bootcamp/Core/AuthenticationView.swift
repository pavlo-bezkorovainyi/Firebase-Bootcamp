//
//  AuthenticationView.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 10.07.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
  
  @StateObject private var viewModel = AuthenticationVieModel()
  @Binding var showSignedInView: Bool
  
  var body: some View {
    VStack {
      
      Button {
        Task {
          do {
            try await viewModel.signInAnonymous()
            showSignedInView = false
          } catch {
            print(error)
          }
        }
      } label: {
        Text("Sign In Anonymuosly")
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.orange)
          .cornerRadius(10)
        
      }
      
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
      
      
      Button(action: {
        Task {
          do {
            try await viewModel.signInApple()
            showSignedInView = false
          } catch {
            print(error)
          }
        }
      }, label: {
        SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
          .allowsHitTesting(false)
      })
      .frame(height: 55)
      
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
