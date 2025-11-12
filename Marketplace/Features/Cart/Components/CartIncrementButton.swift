//
//  CartIncrementButton.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 05/11/2025.
//

import SwiftUI


struct CartIncrementButton<Item: ItemDisplayable>: View {
    var cartItem: Item
    let onDelete: (Item) -> Void
    @Environment(\.modelContext) var modelContext
    var count: Int = 1
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 24) {
            
            // Ellipsis menu
            Menu {
                Button("Delete", role: .destructive) {
                    onDelete(cartItem)
                }
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.black)
            }
            
            // Increment/decrement row
            HStack(spacing: 14) {
                
                // Minus button
                Button(action: {
                    if let cartProduct = cartItem as? CartProduct {
                        cartProduct.quantity = max(1, (cartProduct.quantity ?? 1) - 1)
                    }
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.black)
                        .frame(width: 24, height: 24)
                        .background(Color(.card))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                .buttonStyle(.plain)
                
                // Quantity text
                if let quantity = cartItem.quantity {
                    Text("\(quantity.description)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                }
              
                
                // Plus button
                Button(action: {
                    if let cartProduct = cartItem as? CartProduct {
                        cartProduct.quantity = (cartProduct.quantity ?? 1) + 1
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(Color(.primary))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                .buttonStyle(.plain)
            }
        }
    }
}
