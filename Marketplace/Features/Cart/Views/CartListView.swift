//
//  CartListView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 01/11/2025.
//

import SwiftUI
import SwiftData

struct CartListView: View {
    @Query(filter: #Predicate { $0.isCart }, sort: [SortDescriptor(\CartProduct.title, order: .reverse)], animation: .default) var cartItems: [CartProduct]

    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !cartItems.isEmpty {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 16) {
                    ForEach(cartItems, id: \.id) { product in
                        ItemCard(product: product) { selectedProduct in
                            
                        }
                    }
                }
                .padding(.top, 32)
                .padding(.horizontal, 20)
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

