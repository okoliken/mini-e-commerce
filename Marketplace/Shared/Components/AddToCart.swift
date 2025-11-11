//
//  AddToCart.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/09/2025.
//

import SwiftUI

struct AddToCart: View {
    var width: CGFloat = 30
    var height: CGFloat = 30
    var iconSize: CGFloat = 16
    var product: Product
    let onAddToCart: (Product) -> Void
    let dbManager: HandleDBInteractions  
    
    var body: some View {
        Button {
            withAnimation {
                onAddToCart(product)
            }
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: width, height: height)
                
                Image(systemName: dbManager.isInCart(product.id) ? "cart.fill" : "cart")
                    .font(.system(size: iconSize))
            }
        }
    }
}
