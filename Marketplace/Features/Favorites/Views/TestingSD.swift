//
//  TestingSD.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 24/10/2025.
//

import SwiftUI
import SwiftData

struct TestingSD: View {
    let products: [FavoriteProduct]
        
        var body: some View {
            List {
                ForEach(products, id: \.id) { product in
                    Text("\(product.title)")
                }
            }
        }
}


