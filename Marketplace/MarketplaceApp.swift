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
    @State private var productStore = ProductStore()

    let sharedModelContainer: ModelContainer = {
        let schema = Schema([FavoriteProduct.self, CartProduct.self])
        return try! ModelContainer(for: schema, configurations: [])
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    DataManager(modelContext: sharedModelContainer.mainContext)
                )
                .environment(
                    HandleDBInteractions(modelContext: sharedModelContainer.mainContext)
                )
                .environment(productStore)
                .modelContainer(sharedModelContainer)
        }
    }
}
