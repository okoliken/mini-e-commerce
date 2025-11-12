//
//  ProductDetailView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 19/09/2025.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var isFavorite: Bool = false
    let product: Product
    @Environment(\.dismiss) private var dismiss
    @Environment(HandleDBInteractions.self) var dbInteractions
    
    
    enum ProductCategory {
        case cartItem, FavouriteItem
    }
    
    
    
    func initManager(product: Product, category: ProductCategory = .FavouriteItem) {
        switch category {
            case .FavouriteItem:
                dbInteractions.saveProductToFavourite(product)
                break
            case .cartItem:
                dbInteractions.saveProductToCart(product)
                break
        }
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                ZStack(alignment: .center) {
                                    
                                    Rectangle()
                                        .fill(Color(.card))
                                    
                                    Image(product.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 315)
                                    
                                }
                                VStack(spacing: 8){
                                    FavoriteButton(
                                        width: 40,
                                        height: 40,
                                        iconSize: 20,
                                        product: product,
                                        onFavorite: { product in
                                            self.initManager(product: product)
                                        },
                                        dbManager: dbInteractions
                                    )
                                    
                                    AddToCart(
                                        width: 40,
                                        height: 40,
                                        iconSize: 20,
                                        product: product,
                                        onAddToCart: { product in
                                            self.initManager(product: product, category: .cartItem)
                                        },
                                        dbManager: dbInteractions)
                                }
                                .padding(16)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            
                        }
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height * 0.6
                        )
                        
                        VStack(alignment: .leading) {
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Text("\(product.title)")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            if let model = product.model {
                                Text("\(model)")
                            }
                            
                            Text("\(product.productDescription)")
                                .font(.callout)
                                .foregroundColor(.black)
                                .opacity(0.4)
                                .padding(.top, 20)
                        }
                        .padding(.top, 16)
                    }
                }
                
                
            }
        }
        .padding(.horizontal, 8)
        .navigationToolbarModifier(title: product.model ?? product.category, backPath: {dismiss()})
    }
}
