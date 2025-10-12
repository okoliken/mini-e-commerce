//
//  AddToCart.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/09/2025.
//

import SwiftUI

struct AddToCart: View {
    var width: CGFloat = 30
    var height: CGFloat = 30
    var iconSize: CGFloat = 16
    
    var body: some View {
        Button {
         
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: width, height: height)
                
                Image("cart_icon")
                    .foregroundColor(.black)
                    .font(.system(size: iconSize))
            }
        }
    }
}

#Preview {
    AddToCart()
}
