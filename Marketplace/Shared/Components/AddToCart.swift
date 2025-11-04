//
//  AddToCart.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/09/2025.
//

import SwiftUI

struct AddToCart: View {
    @State var isAddedToCart: Bool = false
    var width: CGFloat = 30
    var height: CGFloat = 30
    var iconSize: CGFloat = 16
    var product: Product
    let onAddToCart: (Product) -> Void
    let itemExistsInDb: Bool

    
    var body: some View {
        Button {
            withAnimation {
                onAddToCart(product)
                isAddedToCart.toggle()
            }
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: width, height: height)
                
                Image(systemName: (isAddedToCart || itemExistsInDb) ? "cart.fill" : "cart")
                    .foregroundColor(.black)
                    .font(.system(size: iconSize))
            }
        }
        .onChange(of: itemExistsInDb) {
            isAddedToCart = itemExistsInDb
        }
    }
}


