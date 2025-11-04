//
//  DataDBManager.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 24/10/2025.
//
import SwiftUI
import SwiftData

class DataManager: ObservableObject {
    @Published var favoriteIDs: Set<String> = []
    @Published var cartItemsIDs: Set<String> = []
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add<T: PersistentModel>(_ item: T) {
        modelContext.insert(item)
        self.save()
    }
    
    func delete(_ object: some PersistentModel, in context: ModelContext) {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func itemExists<T: PersistentModel>(_ type: T.Type, predicate: Predicate<T>) -> Bool {
        do {
            let descriptor = FetchDescriptor<T>(predicate: predicate)
            let result = try modelContext.fetch(descriptor)
            return !result.isEmpty
        } catch {
            print("\(error.localizedDescription)")
            return false
        }
    }
    
    func fetchSingleItem<T: PersistentModel>(_ type: T.Type, predicate: Predicate<T>, in context: ModelContext) -> T? {
        do {
            let descriptor = FetchDescriptor<T>(predicate: predicate)
            let result = try context.fetch(descriptor)
            return result.first
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }
    
    func save() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}

class HandleDBInteractions: DataManager {
    let product: Product
    
    init(product: Product, modelContext: ModelContext ) {
        self.product = product
        super.init(modelContext: modelContext)
        self.loadFavoriteIDs()
    }
    
    private func loadFavoriteIDs() {
        do {
            let descriptor = FetchDescriptor<FavoriteProduct>(predicate: #Predicate { $0.isFavorite })
            let favorites = try modelContext.fetch(descriptor)
            self.favoriteIDs = Set(favorites.map { $0.id })
        } catch {
            print("Error loading favorite IDs: \(error.localizedDescription)")
        }
    }
    
    
    var existsInFavorite: Bool {
        let id = product.id
        return self.favoriteIDs.contains(product.id) || self.itemExists(FavoriteProduct.self, predicate: #Predicate { $0.id == id })
    }
    
    
    var existsInCart: Bool {
        let id = product.id
        return self.cartItemsIDs.contains(product.id) || self.itemExists(CartProduct.self, predicate: #Predicate { $0.id == id })
    }
    
    func saveProductToFavourite(_ product: Product) {
        let productId = product.id
        let isFavorite = self.favoriteIDs.contains(productId)
        if isFavorite {
            if let itemToDelete = self.fetchSingleItem(
                FavoriteProduct.self,
                predicate: #Predicate { $0.id == productId },
                in: self.modelContext
            ) {
                self.favoriteIDs.remove(productId)
                self.delete(itemToDelete, in: modelContext)
            }
        } else {
            self.favoriteIDs.insert(productId)
            self.add(FavoriteProduct(
                id: product.id,
                title: product.title,
                category: product.category,
                price: product.price,
                imageName: product.imageName,
                oldPrice: product.oldPrice,
                productDescription: product.productDescription,
                isFavorite: true,
                model: product.model
            ))
        }
    }
    
    func saveProductToCart(_ product: Product) {

        let productId = product.id
        let isCart = self.cartItemsIDs.contains(productId)
        if isCart {
            if let itemToDelete = self.fetchSingleItem(
                CartProduct.self,
                predicate: #Predicate { $0.id == productId },
                in: self.modelContext
            ) {
                self.cartItemsIDs.remove(productId)
                self.delete(itemToDelete, in: modelContext)
            }
        } else {
          
            if self.existsInFavorite {
                print("in here")
                let productEx = self.fetchSingleItem(FavoriteProduct.self, predicate: #Predicate { $0.id == productId }, in: self.modelContext)
                
                if let productFound = productEx {
                    self.delete(productFound, in: self.modelContext)
                }
               
            }
            
            else {
                self.cartItemsIDs.insert(productId)
                self.add(CartProduct(
                    id: product.id,
                    title: product.title,
                    category: product.category,
                    price: product.price,
                    imageName: product.imageName,
                    oldPrice: product.oldPrice,
                    productDescription: product.productDescription,
                    isCart: true,
                    model: product.model
                ))
            }
        }
    }
}
