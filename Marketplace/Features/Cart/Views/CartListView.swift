//
//  CartListView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 01/11/2025.
//

import SwiftUI
import SwiftData

struct CartListView: View {
    @Query(
        filter: #Predicate {
            $0.isCart
        },
        sort: [SortDescriptor(
            \CartProduct.title,
             order: .forward
        )]) var cartItems: [CartProduct]
    
    @Environment(HandleDBInteractions.self) var dbInteractions
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !cartItems.isEmpty {
            VStack(spacing: 0){
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 16) {
                        ForEach(cartItems, id: \.id) { product in
                            ItemCard(product: product, presentationView: .cart, onRemoveItem: { selectedProduct in
                                dbInteractions.cartItemsIDs.remove(selectedProduct.id)
                                dbInteractions.delete(selectedProduct, in: modelContext)
                            })
                        }
                    }
                    .padding(.top, 32)
                    .padding(.horizontal, 20)
                }
                .padding(0)
    
                if !cartItems.isEmpty {
                    CheckoutSection()
                }
               
            }
        }
        else {
            EmptyStateView(
                title: "No Items in cart",
                description: "Items you mark as favorites will appear here.",
                systemImage: "heart.slash")
        }
    }
}

struct CheckoutSection: View {
    var body: some View {
        Divider()
        VStack(alignment: .trailing) {
            VStack(alignment: .leading, spacing: 8) {
                
                HStack{
                    Text("Shipping")
                        .font(.caption)
                        .fontWeight(.medium)
                    Spacer()
                    Text("$0.00")
                        .font(.caption)
                }

                HStack{
                    Text("Total ")
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .font(.caption)
                    + Text("TVA included")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.4))
                    
                    Spacer()
                    Text("$695.07")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                
                Button(action: {}) {
                   Text("Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .background(Color.black)
                        .font(.callout)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white)
                }
               
                
            }
            .padding(.top, 8)
            .padding(.horizontal, 20)
        }
        
        Spacer()
    }
}

