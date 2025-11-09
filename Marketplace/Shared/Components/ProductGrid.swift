//
//  ProductCard.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 16/09/2025.
//

import SwiftUI
import SwiftData

struct ProductGrid: View {
    let productList: [Product]
    let columns: [GridItem]
    @Environment(\.modelContext) var modelContext
    @Environment(HandleDBInteractions.self) var dbInteractions
    
    var body: some View {
        ZStack {
            if productList.isEmpty {
                EmptyStateView(
                    title: "No Products Available",
                    description: "New products will appear here once they’re added.",
                    systemImage: "shippingbox")
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            } else {
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(productList) { product in
                        ProductCardView(product: product, onSaveProduct: { product in
                            dbInteractions.saveProductToFavourite(product)
                        })
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 1.05)))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: productList)
    }
}



struct ProductCardHeader : View {
    let product: Product
    let existsInFavorite: Bool
    
    let onSaveProduct: (Product) -> Void
    var body: some View {
        ZStack(alignment: .topTrailing) {
           
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color(.card))
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 170)
            }
            FavoriteButton(
                product: product,
                onFavorite: { product in
                    onSaveProduct(product)
                },
                itemExistsInDb: existsInFavorite
            )
            .padding(12)
            
        }
        .frame(maxWidth: .infinity, minHeight: 170)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

struct ProductCardDetails: View {
    let product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 6) {
                if product.oldPrice > product.price {
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.sale)
                    Text("$\(product.oldPrice, specifier: "%.2f")")
                        .font(.system(size: 14))
                        .strikethrough(true, color: .gray)
                        .foregroundColor(.gray)
                } else {
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                }
            }
            
            Text(product.title)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .frame(height: 14, alignment: .topLeading)
            
            if let model = product.model {
                Text(model)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 4)
    }
}


struct ProductCardView: View {
    let product: Product
    let onSaveProduct: (Product) -> Void

    @Environment(DataManager.self) var dataManager: DataManager
    
    var isFavorite: Bool {
        let id = product.id
        let exits = dataManager.favoriteIDs.contains(product.id) || dataManager.itemExists(FavoriteProduct.self, predicate: #Predicate {$0.id == id})
        return exits
    }
    
    var body: some View {
        NavigationLink(value: product) {
            VStack(alignment: .leading, spacing: 12) {
                ProductCardHeader(
                    product: product,
                    existsInFavorite: isFavorite,
                    onSaveProduct: { product in
                        onSaveProduct(product)
                    }
                )
                ProductCardDetails(product: product)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .transition(.scale(scale: 0.95).combined(with: .opacity))
    }
}
