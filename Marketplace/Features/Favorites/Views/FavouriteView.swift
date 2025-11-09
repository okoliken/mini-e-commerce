//
//  FavouriteView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/10/2025.
//

import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Query(filter: #Predicate { $0.isFavorite }, sort: [SortDescriptor(\FavoriteProduct.title, order: .reverse)], animation: .default) var wishListItems: [FavoriteProduct]
    
    @Environment(DataManager.self) var dataManager: DataManager
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !wishListItems.isEmpty {
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 16) {
                    ForEach(wishListItems, id: \.id) { product in
                        ItemCard(product: product) { selectedProduct in
                            dataManager.favoriteIDs.remove(product.id)
                            dataManager.delete(selectedProduct, in: modelContext)
                        }
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
