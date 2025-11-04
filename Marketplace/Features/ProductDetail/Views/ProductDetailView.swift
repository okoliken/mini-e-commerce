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
    @Environment(\.modelContext) var modelContext
    
    
    enum ProductCategory {
        case cartItem, FavouriteItem
    }
    
    var itemExists: Bool {
        let manager = HandleDBInteractions(product: product, modelContext: modelContext)
        return manager.existsInFavorite
    }
    
    var itemsExsistsInCart: Bool {
        let manager = HandleDBInteractions(product: product, modelContext: modelContext)
        return manager.existsInCart
    }
    
    func initManager(product: Product, category: ProductCategory = .FavouriteItem) {
        let manager = HandleDBInteractions(product: product, modelContext: modelContext)
        switch category {
            case .FavouriteItem:
                manager.saveProductToFavourite(product)
                break
            case .cartItem:
                print("met condition")
                manager.saveProductToCart(product)
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
                                        itemExistsInDb: itemExists
                                        
                                    )
                                    
                                    AddToCart(width: 40, height: 40, iconSize: 20, product: product, onAddToCart: { product in
                                        self.initManager(product: product, category: .cartItem)
                                    }, itemExistsInDb: itemsExsistsInCart)
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
