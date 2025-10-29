//
//  FavoriteButton.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 06/09/2025.
//

import SwiftUI

struct FavoriteButton: View {
    @State var isFavorite: Bool = false
    var width: CGFloat = 30
    var height: CGFloat = 30
    var iconSize: CGFloat = 16
    var product: Product
    let onFavorite: (Product) -> Void
    let itemExistsInDb: Bool

    var body: some View {
        Button {
            withAnimation {
                onFavorite(product)
                isFavorite.toggle()
            }
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: width, height: height)
                
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.black)
                    .font(.system(size: iconSize))
                  
            }
        }
        .onChange(of: itemExistsInDb) {
            isFavorite = itemExistsInDb
        }
    }
}


