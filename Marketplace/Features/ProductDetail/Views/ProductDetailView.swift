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
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.modelContext) var modelContext
    

    func saveProductToLocalDB(_ product: Product) {
        let productId = product.id
        let isFavorite = dataManager.favoriteIDs.contains(productId)

        if isFavorite {
            if let itemToDelete = dataManager.fetchSingleItem(
                FavoriteProduct.self,
                predicate: #Predicate { $0.id == productId },
                in: modelContext
            ) {
                dataManager.favoriteIDs.remove(productId)
                dataManager.delete(itemToDelete, in: modelContext)
            }
        } else {
            dataManager.favoriteIDs.insert(productId)
            dataManager.add(FavoriteProduct(
                id: product.id,
                title: product.title,
                category: product.category,
                price: product.price,
                imageName: product.imageName,
                oldPrice: product.oldPrice,
                productDescription: product.productDescription,
                isFavorite: true,
                model: product.model
            ))
        }
    }
    
    var exists: Bool {
        let id = product.id
        return dataManager.favoriteIDs.contains(product.id) || dataManager.itemExists(FavoriteProduct.self, predicate: #Predicate { $0.id == id })
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
                                            saveProductToLocalDB(product)
                                        },
                                        itemExistsInDb: exists
                                    )
                                        
                                    AddToCart(width: 40, height: 40, iconSize: 20)
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
