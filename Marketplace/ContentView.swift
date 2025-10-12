//
//  ContentView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 02/09/2025.
//

import SwiftUI


struct ContentView: View {
    let service = ProductStore()
    @EnvironmentObject var store: ProductStore
    
    
    
    var body: some View {
        TabView{
            NavigationStack {
                HomeView()
                    .navigationDestination(for: Product.self) { product in
                        ProductDetailView(product: product)
                    }
            }
            .tabItem {
                Image("home_icon")
                Text("Home")
            }
            
            NavigationStack {
                BrowseView()
                    .navigationDestination(for: Category.self) { category in
                        BrowseListView(category: category, products: store.products.filter { $0.category == category.name })
                    }
                    .navigationDestination(for: Product.self) { product in
                        ProductDetailView(product: product)
                    }
            }
            .tabItem {
                Image("browse_icon")
                Text("Browse")
            }
            
            NavigationStack {
                Text("Favorites")
                
            }
            .tabItem {
                Image("favourites_icon")
                Text("Favourites")
            }
            
            
            NavigationStack {
                Image("m2air-hero-6c-removebg-preview")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 170)
                    .border(.red)
            }
            .tabItem {
                Image("cart_icon")
                Text("Cart")
            }
            
            
            NavigationStack {
                Text("Profile")
            }
            .tabItem {
                Image("profile_icon")
                Text("Profile")
            }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}
