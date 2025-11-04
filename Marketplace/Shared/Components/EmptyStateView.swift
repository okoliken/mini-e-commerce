//
//  EmptyStateView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 03/11/2025.
//

import SwiftUI


struct EmptyStateView: View {
    let title: String
    let description: String
    let systemImage: String
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                ContentUnavailableView(
                    title,
                    systemImage: systemImage,
                    description: Text("\(description)")
                )
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .frame(minHeight: 450, alignment: .center)
    }
}
