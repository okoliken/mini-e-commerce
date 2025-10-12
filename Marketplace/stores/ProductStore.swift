//
//  ProductStore.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 04/10/2025.
//

import SwiftUI

@MainActor
class ProductStore: ObservableObject {
    @Published var products: [Product] = []

    init() {
        loadProducts()
    }

    private func loadProducts() {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            products = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print("Error loading JSON: \(error)")
        }
    }
}

