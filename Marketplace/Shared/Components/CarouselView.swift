//
//  CarouselView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 04/09/2025.
//

import SwiftUI

struct CarouselView: View {
    
    let productList: [Product]
    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 6) {
            TabView(selection: $currentIndex) {
                ForEach(productList.indices, id: \.self) { index in
                    CarouselCard(product: productList[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 170)
            .cornerRadius(20)
            
            HStack(spacing: 8) {
                ForEach(0..<productList.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.3))
                        .frame(
                            width: index == currentIndex ? 35 : 9,
                            height: 4
                        )
                        .animation(.easeInOut(duration: 0.3), value: currentIndex)
                        .onTapGesture {
                            currentIndex = index
                        }
                }
            }
        }
    }
}

