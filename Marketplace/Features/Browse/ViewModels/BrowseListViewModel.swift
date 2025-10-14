//
//  BrowseListViewModel.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 11/10/2025.
//
import Foundation


enum SortOption: String, CaseIterable {
    case relevance = "Relevance"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case brandAZ = "Brand: A–Z"
    case discountHighToLow = "Biggest Discount"
}


public class BrowseListViewModel: ObservableObject {
    @Published var selectedFilterTags: [String] = []
    @Published var products: [Product] = []
    
    @Published var selectedBrand: String? = nil {
        didSet {
            self.updateFilterTags()
        }
    }
    @Published var selectedPrice: Double? {
        didSet {
            self.updateFilterTags()
        }
    }
    @Published var selectedModel: String? {
        didSet {
            self.updateFilterTags()
        }
    }
    
    @Published var selectedSortOption: SortOption = .relevance
    
    
    init(products: [Product]) {
        self.products = products
    }
    
    private func updateFilterTags() {
        var filterTags: [String] = []
        
        if let selectedBrand = self.selectedBrand, !selectedBrand.isEmpty {
            filterTags.append("Brand")
        }
        
        if let selectedPrice = self.selectedPrice, !selectedPrice.isNaN {
            filterTags.append("Price Range")
        }
        
        if let selectedModel = self.selectedModel, !selectedModel.isEmpty {
            filterTags.append("Model")
        }
        
        self.selectedFilterTags = filterTags
    }
    
    
    var productBrands: [String] {
        Array(Set(self.products.compactMap { $0.brand }))
    }
    
    var availablePrices: [String: Double] {
        var priceList: [String: Double] = [:]
        var seenPrice: Set<Double> = []
        
        
        for (_, product) in products.enumerated() {
            if !seenPrice.contains(product.price){
                priceList["$\(product.price)"] = product.price
                seenPrice.insert(product.price)
            }
            
        }
        
        return priceList
        
    }
    
    var availableModels: [String] {
        let models = products.compactMap { $0.model }
        return Array(Set(models)).sorted()
    }
    
    
    var filterableProducts: [Product] {
        self.products.filter { product in
            var matchesFilters = true
            
            if let selectedBrand = self.selectedBrand, !selectedBrand.isEmpty {
                matchesFilters = matchesFilters && (product.brand ?? "").lowercased() == selectedBrand.lowercased()
            }
            
            if let selectedPrice = self.selectedPrice {
                return product.price == selectedPrice
            }
            
            if let selectedModel = self.selectedModel, !selectedModel.isEmpty {
                matchesFilters = matchesFilters && (product.model ?? "").lowercased().contains(selectedModel.lowercased())
            }
            
            return matchesFilters
        }
        
    }
    
    var sortedProducts: [Product] {
        let base = self.filterableProducts
        switch self.selectedSortOption {
        case .priceHighToLow:
            return base.sorted { $0.price > $1.price }
        case .priceLowToHigh:
            return base.sorted { $0.price < $1.price }
        case .brandAZ:
            return base.sorted { $0.brand ?? "" < $1.brand ?? "" }
        case .discountHighToLow:
            return base.sorted {
                (($0.oldPrice - $0.price) / $0.oldPrice)
                > (($1.oldPrice - $1.price) / $1.oldPrice)
            }
        default:
            return self.filterableProducts
        }
    }
    
    
    func resetFilters() {
        self.selectedBrand = nil
        self.selectedPrice = nil
        self.selectedModel = nil
        self.selectedSortOption = .relevance
    }
    
    
    func clearFilter(_ tag: String) {
        switch tag.lowercased() {
        case "brand":
            self.selectedBrand = nil
        case "price":
            self.selectedPrice = nil
        case "model":
            self.selectedModel = nil
        default:
            break
        }
        
        self.selectedFilterTags.removeAll { $0.lowercased() == tag.lowercased() }
    }
    
}



