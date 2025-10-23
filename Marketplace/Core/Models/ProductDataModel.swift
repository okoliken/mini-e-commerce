//
//  ProductDataModel.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 21/10/2025.
//
import Foundation
import SwiftData

@Model
class FavoriteProduct {
    var id: String
    var title: String
    var category: String
    var price: Double
    var imageName: String
    var oldPrice: Double
    var productDescription: String
    
    init(id: String, title: String, category: String, price: Double, imageName: String, oldPrice: Double, productDescription: String) {
        self.id = id
        self.title = title
        self.category = category
        self.imageName = imageName
        self.price = price
        self.oldPrice = oldPrice
        self.productDescription = productDescription
    }
}
