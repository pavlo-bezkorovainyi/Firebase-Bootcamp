//
//  OnFirstAppearViewModifier.swift
//  Firebase Bootcamp
//
//  Created by Pavlo Bezkorovainyi on 04.09.2024.
//

import SwiftUI

struct OnFirstAppearViewModifier: ViewModifier {
  
  @State private var didAppear: Bool = false
  let perform: (() -> Void)?
  
  func body(content: Content) -> some View {
    content
      .onAppear {
        if !didAppear {
          perform?()
          didAppear = true
        }
      }
  }
}

extension View {
  func onFirstAppear(perform: (() -> Void)?) -> some View {
    modifier(OnFirstAppearViewModifier(perform: perform))
  }
}
