//
//  HomeView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 02/09/2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var store: ProductStore
    @State private var selected: String = "All"
    
    let dealsOfTheDay: [Product] = [
        Product(
            id: "2",
            title: "Galaxy SmartWatch",
            category: "Wearables",
            price: 249.99,
            oldPrice: 299.99,
            description: "Fitness tracking, notifications, and health monitoring",
            imageName: "smartwatch",
            model: "Model: WH-1000XM4, Black",
            brand: "Samsung"
        ),
        Product(
            id: "1",
            title: "RØDE PodMic",
            category: "Microphones",
            price: 108.20,
            oldPrice: 199.99,
            description: "Dynamic microphone, Speaker microphone",
            imageName: "rodemicrophone",
            model: "Model: WH-1000XM4, Black",
            brand: "LG"
        ),
        Product(
            id: "3",
            title: "SONY Premium Headphones",
            category: "Smartphones",
            price: 699.00,
            oldPrice: 799.00,
            description: "High-performance smartphone with advanced camera system",
            imageName: "headphones",
            model: "Model: WH-1000XM4, Black",
            brand: "Sony"
        )
    ]
    
    var categoriesList: [String] {
        if store.products.isEmpty {
            return []
        } else {
            let uniqueList = ["All"] + Set(store.products.map {$0.category }).sorted()
            
            return uniqueList
        }
    }
    
    
    
    var productGridList: [Product] {
        Array(store.products.prefix(10))
    }
    

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Hello Michael")
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                    .foregroundColor(.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 32) {
                        ForEach(categoriesList, id: \.self) { category in
                            CategoryTab(category: category, selected: $selected)
                        }
                    }
                }
                
                HStack {
                    Text("Deals of the day")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button("See all"){}
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 12)
                
                CarouselView(productList: dealsOfTheDay)
                
                VStack(alignment: .leading) {
                    Text("Recommended for you")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    ProductGrid(productList: productGridList, columns: [
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
}
