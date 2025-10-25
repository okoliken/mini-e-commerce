//
//  DealsHeaderText.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 24/10/2025.
//

import SwiftUI

struct DealsHeaderText: View {
    var body: some View {
        HStack {
            Text("Deals of the day")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Button("See all"){}
                .font(.callout)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 12)
    }
}
