//
//  ItemCard.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 23/10/2025.
//

import SwiftUI

struct ItemCard: View {
    let product: FavoriteProduct
    let onDelete: (FavoriteProduct) -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                Rectangle()
                    .fill(Color(.card))
                    .cornerRadius(24)
                
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 80, height: 88)
            
            VStack(alignment: .leading){
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.callout)
                    .fontWeight(.heavy)
                
                Text("\(product.title)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                
                Text("\(product.model ?? "")")
                    .font(.caption)
                    .foregroundColor(.black)
                    .opacity(0.4)
            }
            
            Spacer()
            
            HStack(spacing: 16){
                ZStack {
                    Rectangle()
                        .fill(Color(.card))
                        .cornerRadius(12)
                    
                    Image("cart_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 19, height: 19)
                }
                .frame(width: 40, height: 40)
                
                Menu {
                    Button("Delete") {
                        self.onDelete(product)
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
