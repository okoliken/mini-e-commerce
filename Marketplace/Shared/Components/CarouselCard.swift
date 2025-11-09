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
    @Environment(\.modelContext) var modelContext
    @Environment(HandleDBInteractions.self) var dbInteractions
    @Environment(DataManager.self) var dataManager: DataManager
    
    
    var isexr: Bool {
        let id = product.id
        let exits = dataManager.favoriteIDs.contains(product.id) || dataManager.itemExists(FavoriteProduct.self, predicate: #Predicate {$0.id == id})
        return exits
    }

    
    func initManager(product: Product) {
        
        dbInteractions.saveProductToFavourite(product)
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
                    self.initManager(product: product)
                },
                itemExistsInDb: isexr
            )
            .padding(16)
        }
    }
}


