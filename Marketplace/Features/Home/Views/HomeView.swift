//
//  HomeView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 02/09/2025.
//

import SwiftUI



struct HomeView: View {
    @EnvironmentObject var store: ProductStore
    @State private var selected: String = "all"
    

    var categoriesList: [String] {
        if store.products.isEmpty {
            return []
        } else {
            let uniqueList = ["All"] + Set(store.products.map {$0.category }).sorted()
            
            return uniqueList
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                
                HeaderView(categoriesList: categoriesList, selected: $selected)
                DealsHeaderText()
                
                CarouselView(productList: Constants.dealsOfTheDay) 
                
                VStack(alignment: .leading) {
                    Text("Recommended for you")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    ProductGrid(productList: Array(store.products.prefix(10)),
                     columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ])
                }
                .padding(.top, 24)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 20)
            .scrollTargetBehavior(.paging)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ProductStore())
        .modelContainer(for: FavoriteProduct.self)
}
