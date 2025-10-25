//
//  ProductDataModel.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 21/10/2025.
//
import Foundation
import SwiftData

@Model
final class FavoriteProduct {
    var id: String = UUID().uuidString
    var title: String
    var category: String
    var price: Double
    var imageName: String
    var oldPrice: Double
    var productDescription: String
    var isFavorite: Bool
    var model: String?
    
    init(id: String,
         title: String,
         category: String,
         price: Double,
         imageName: String,
         oldPrice: Double,
         productDescription: String,
         isFavorite: Bool,
         model: String?
        ) {
        self.id = id
        self.title = title
        self.category = category
        self.imageName = imageName
        self.price = price
        self.oldPrice = oldPrice
        self.productDescription = productDescription
        self.isFavorite = isFavorite
        self.model = model
    }
}
