//
//  ContentView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 02/09/2025.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    let service = ProductStore()
    @EnvironmentObject var store: ProductStore
    @Query(sort: [SortDescriptor(\FavoriteProduct.title, order: .reverse)],animation: .easeInOut) var wishListItems: [FavoriteProduct]
    
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
                FavouriteView()
                    .navigationTitle("Favourites")
                    .navigationBarTitleDisplayMode(.inline)
            }
            
            .tabItem {
                Image("favourites_icon")
                Text("Favourites")
            } .badge(wishListItems.count)
            
            
            NavigationStack {
              
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
        .environmentObject(ProductStore())
}
