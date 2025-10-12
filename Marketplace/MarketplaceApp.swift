//
//  MarketplaceApp.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 02/09/2025.
//

import SwiftUI

@main
struct MarketplaceApp: App {
    @StateObject private var productStore = ProductStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(productStore)
        }
    }
}
