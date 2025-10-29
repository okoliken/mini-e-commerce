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
    let productDescription: String
    let imageName: String
    var model: String?
    let brand: String?
    let year: Int
}

struct Category: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
}


