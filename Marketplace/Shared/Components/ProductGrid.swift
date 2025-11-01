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
    @Environment(\.modelContext) var modelContext
    
    
    
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
                        ProductCardView(product: product) { product in
                            let manager = HandleDBInteractions(product: product, modelContext: modelContext)
                            manager.saveProductToLocalDB(product)
                        }
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 1.05)))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: productList)
    }
}


struct EmptyStateView: View {
    let title: String
    let description: String
    let systemImage: String
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                ContentUnavailableView(
                    title,
                    systemImage: systemImage,
                    description: Text("\(description)")
                )
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .frame(minHeight: 450, alignment: .center)
    }
}


struct ProductCardView: View {
    let product: Product
    let onSaveProduct: (Product) -> Void
    @Environment(\.modelContext) var modelContext
    

    var exists: Bool {
        let manager = HandleDBInteractions(product: product, modelContext: modelContext)
        return manager.exists
    }
    
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
                    FavoriteButton(
                        product: product,
                        onFavorite: { product in
                            onSaveProduct(product)
                        },
                        itemExistsInDb: exists
                    )
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .transition(.scale(scale: 0.95).combined(with: .opacity))
    }
}
