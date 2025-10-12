//
//  NavigationModifiers.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 23/09/2025.
//

import SwiftUI


struct NavigationModifier: ViewModifier {
    let title: String
    let backPath: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: backPath) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }
                }
                
                
                ToolbarItem(placement: .principal) {
                    Button(action: backPath) {
                        Text("\(title)")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { print("Search tapped") }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }
                }
            }
    }
}

extension View {
    func navigationToolbarModifier(title: String, backPath: @escaping () -> Void) -> some View {
        modifier(NavigationModifier(title: title, backPath: backPath))
    }
}
