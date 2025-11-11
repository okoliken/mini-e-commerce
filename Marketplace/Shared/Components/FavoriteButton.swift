//
//  FavoriteButton.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 06/09/2025.
//

import SwiftUI

struct FavoriteButton: View {
    var width: CGFloat = 30
    var height: CGFloat = 30
    var iconSize: CGFloat = 16
    var product: Product
    let onFavorite: (Product) -> Void
    let dbManager: HandleDBInteractions
    
    var body: some View {
        Button {
            withAnimation {
                onFavorite(product)
            }
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: width, height: height)
                
                Image(systemName: dbManager.isFavorited(product.id) ? "heart.fill" : "heart")
                    .font(.system(size: iconSize))
            }
        }
    }
}


