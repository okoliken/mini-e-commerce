//
//  FavouriteView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/10/2025.
//

import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Query(sort: [SortDescriptor(\FavoriteProduct.title, order: .reverse)]) var wishListItems: [FavoriteProduct]
    
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        if !wishListItems.isEmpty {
            ScrollView(.vertical){
                VStack(spacing: 16) {
                    ForEach(wishListItems, id: \.id) { product in
                        ItemCard(product: product) { selectedProduct in
                            dataManager.delete(selectedProduct, in: modelContext)
                        }
                    }
                }
                .padding(.top, 32)
                .padding(.horizontal, 20)
            }
        }
        else {
            EmptyCart(text: "No items in your wishlist")
        }
    }
}
