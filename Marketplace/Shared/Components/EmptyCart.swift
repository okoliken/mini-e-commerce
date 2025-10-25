//
//  EmptyCart.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 25/10/2025.
//

import SwiftUI

struct EmptyCart: View {
    var text: String = "Category not found"
        
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("remove_14813893")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                Text(text)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .font(.callout)
            }
           
            Spacer()
        }
    }
}
