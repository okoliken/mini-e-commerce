//
//  Product.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 04/09/2025.
//

import Foundation

struct Product: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let category: String
    let price: Double
    let oldPrice: Double
    let description: String
    let imageName: String
    let model: String?
    let brand: String?
}

struct Category: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
}


