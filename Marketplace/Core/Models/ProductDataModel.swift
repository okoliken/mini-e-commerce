//
//  ProductDataModel.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 21/10/2025.
//
import Foundation
import SwiftData

protocol ItemDisplayable {
    var id: String { get }
    var title: String { get }
    var price: Double { get }
    var oldPrice: Double { get }
    var imageName: String { get }
    var model: String? { get }
    var quantity: Int? { get set }
}


@Model
class FavoriteProduct: ItemDisplayable {
    var id: String = UUID().uuidString
    var title: String
    var category: String
    var price: Double
    var imageName: String
    var oldPrice: Double
    var productDescription: String
    var isFavorite: Bool
    var model: String?
    var quantity: Int?
    
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

@Model
class CartProduct: ItemDisplayable {
    var id: String = UUID().uuidString
    var title: String
    var category: String
    var price: Double
    var imageName: String
    var oldPrice: Double
    var productDescription: String
    var isCart: Bool
    var model: String?
    var quantity: Int? = 1
    
    init(
        id: String,
        title: String,
        category: String,
        price: Double,
        imageName: String,
        oldPrice: Double,
        productDescription: String,
        isCart: Bool,
        model: String?
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.imageName = imageName
        self.price = price
        self.oldPrice = oldPrice
        self.productDescription = productDescription
        self.isCart = isCart
        self.model = model
    }
}


