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
    @State var toggleFavorite: Bool = false
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 18) {
            ForEach(productList) { product in
                NavigationLink(value: product) {
                    VStack(alignment: .leading, spacing: 12) {
                        ZStack(alignment: .topTrailing) {
                            ZStack(alignment: .center){
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
                        
                        // Product details
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .center, spacing: 6) {
                                if product.oldPrice > product.price {
                                    Text("$\(product.price, specifier: "%.2f")")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.sale)
                                    Text("$\(product.oldPrice, specifier: "%.2f")")
                                        .font(.system(size: 14, weight: .regular))
                                        .strikethrough(true, color: .gray)
                                        .foregroundColor(.gray)
                                } else {
                                    Text("$\(product.price, specifier: "%.2f")")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            // Product title
                            Text(product.title)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.primary)
                                .frame(height: 14, alignment: .topLeading)
                            
                            // Model info
                            if let model = product.model {
                                Text("\(model)")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.clear)
                }
            }
        }
    }
}
