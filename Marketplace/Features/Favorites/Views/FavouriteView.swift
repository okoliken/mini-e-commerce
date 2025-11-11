//
//  FavouriteView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/10/2025.
//

import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Query(
        filter: #Predicate {
            $0.isFavorite
        },
        sort: [SortDescriptor(
            \FavoriteProduct.title,
             order: .reverse
        )],
        animation: .default) var wishListItems: [FavoriteProduct]
    
    @Environment(HandleDBInteractions.self) var dbInteractions
    @Environment(\.modelContext) var modelContext
    
    func initManager(product: FavoriteProduct) {
        let productItem = CartProduct(
            id: product.id,
            title: product.title,
            category: product.category,
            price: product.price,
            imageName: product.imageName,
            oldPrice: product.oldPrice,
            productDescription: product.productDescription,
            isCart: true,
            model: product.model,
        )
        
        if !dbInteractions.isInCart(productItem.id) {
            dbInteractions.add(productItem)
        } else {
            dbInteractions.delete(productItem, in: modelContext)
        }
    }
    
    var body: some View {
        if !wishListItems.isEmpty {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 16) {
                    ForEach(wishListItems, id: \.id) { product in
                        ItemCard(
                            product: product,
                            presentationView: .favourite,
                            dbManager: dbInteractions,
                            onRemoveItem: { selectedProduct in
                                dbInteractions.favoriteIDs.remove(product.id)
                                dbInteractions.delete(selectedProduct, in: modelContext)
                            },
                            onAddToCart: { product in
                                initManager(product: product)
                            })
                    }
                }
                .padding(.top, 32)
                .padding(.horizontal, 20)
            }
        }
        else {
            EmptyStateView(
                title: "No Favorites",
                description: "Items you mark as favorites will appear here.",
                systemImage: "heart.slash")
        }
    }
}
