//
//  FavouriteView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/10/2025.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 16) {
                ForEach(Constants.fakePreviewData, id: \.id) { product in
                    ItemCard(product: product)
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 20)
        }
    }
}



#Preview {
    FavouriteView()
}
