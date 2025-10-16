//
//  ProductCard.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 16/09/2025.
//

import SwiftUI


struct ProductGrid: View {
    let productList: [Product]
    let columns: [GridItem]
    @State private var toggleFavorite: Bool = false
    
    var body: some View {
        ZStack {
            if productList.isEmpty {
                EmptyStateView()
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            } else {
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(productList) { product in
                        ProductCardView(product: product, toggleFavorite: $toggleFavorite)
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 1.05)))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: productList)
    }
}


struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("remove_14813893")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                Text("Products not found")
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .font(.callout)
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}


struct ProductCardView: View {
    let product: Product
    @Binding var toggleFavorite: Bool
    var body: some View {
        NavigationLink(value: product) {
            VStack(alignment: .leading, spacing: 12) {
                ZStack(alignment: .topTrailing) {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(Color(.card))
                        Image(product.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 170)
                    }
                    FavoriteButton(isFavorite: $toggleFavorite)
                        .padding(12)
                }
                .frame(maxWidth: .infinity, minHeight: 170)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                
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
                        .font(.system(size: 14, weight: .medium))
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .transition(.scale(scale: 0.95).combined(with: .opacity))
    }
}
