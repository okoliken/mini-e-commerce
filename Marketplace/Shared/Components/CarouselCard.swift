//
//  ProductCard.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 04/09/2025.
//

import SwiftUI

struct CarouselCard: View {
    let product: Product
    @State var isFavorite: Bool = false
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
        ZStack(alignment: .topTrailing) {
            
            VStack {
                HStack (alignment: .center, spacing: 8){
                    ZStack(alignment: .bottom){
                        Image(product.imageName)
                            .resizable()
                            .scaledToFill()
                        
                            .frame(width: 120, height: 134)
                            .padding()
                        
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text(product.category)
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 4) {
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.callout)
                                .fontWeight(.heavy)
                                .foregroundColor(.sale)
                            
                            Text("$\(product.oldPrice, specifier: "%.2f")")
                                .strikethrough()
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Text(product.title)
                            .font(.callout)
                            .fontWeight(.medium)
                        
                        Text(product.productDescription)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
            }
            .padding()
            .frame(height: 170)
            .background(Color(.card))
            .cornerRadius(20)
            
            FavoriteButton(
                product: product,
                onFavorite: { product in
                    saveProductToLocalDB(product)
                },
                itemExistsInDb: exists
            )
            .padding(16)
        }
    }
}


