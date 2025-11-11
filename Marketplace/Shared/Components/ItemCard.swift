//
//  ItemCard.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 23/10/2025.
//

import SwiftUI
import SwiftData


enum PresentationView {
    case favourite, cart
}


struct ItemCard<Item: ItemDisplayable>: View {
    let product: Item
    let dbManager: HandleDBInteractions?
    let presentationView: PresentationView
    let onRemoveItem: ((Item) -> Void)?
    let onAddToCart: ((Item) -> Void)?


    
    init(
        product: Item,
        presentationView: PresentationView,
        dbManager: HandleDBInteractions? = nil,
        onRemoveItem: ((Item) -> Void)? = nil,
        onAddToCart: ((Item) -> Void)? = nil
    ) {
        self.product = product
        self.presentationView = presentationView
        self.dbManager = dbManager
        self.onRemoveItem = onRemoveItem
        self.onAddToCart = onAddToCart
    }
    
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
                    .lineLimit(1)
                
                Text("\(product.model ?? "")")
                    .font(.caption)
                    .foregroundColor(.black)
                    .opacity(0.4)
            }
            
            Spacer()
            
            if presentationView == .favourite {
                HStack(spacing: 16){
                    ZStack {
                        Rectangle()
                            .fill(Color(.card))
                            .cornerRadius(12)
                        
                        Button {
                            if let onAddToCart = onAddToCart {
                                onAddToCart(product)
                            }
                        } label: {
                            if let dbManager = dbManager {
                                Image(systemName: dbManager.isInCart(product.id) ? "cart.fill" : "cart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 19, height: 19)
                            }
                           
                        }
                    }
                    .frame(width: 40, height: 40)
                    
                    Menu {
                        Button("Delete") {
                            if let onRemoveItem = onRemoveItem {
                                onRemoveItem(product)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .frame(width: 20, height: 20)
                    }
                }
            }
            
            else {
                CartIncrementButton(cartItem: product) { cartItem in
                    print(cartItem.title)
                    if let onRemoveItem = onRemoveItem {
                        onRemoveItem(cartItem)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

