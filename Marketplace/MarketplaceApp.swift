//
//  MarketplaceApp.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 02/09/2025.
//

import SwiftUI
import SwiftData

@main
struct MarketplaceApp: App {
    @StateObject private var productStore = ProductStore()
  
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([FavoriteProduct.self])
        return try! ModelContainer(for: schema, configurations: [])
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(
                    DataManager(modelContext: sharedModelContainer.mainContext)
                )
                .environmentObject(productStore)
                .modelContainer(for: FavoriteProduct.self)
        }
    }
}
