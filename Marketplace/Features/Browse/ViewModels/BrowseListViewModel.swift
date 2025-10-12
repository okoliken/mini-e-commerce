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
    private var selectedFilterTags: [String] = []
    @Published var products: [Product] = []
    @Published var selectedBrand: String? = nil
    @Published var selectedPrice: Double?
    @Published var selectedSortOption: SortOption = .relevance
    
    
    init(products: [Product]) {
        self.products = products
    }
    
    var productBrands: [String] {
        Array(Set(self.products.compactMap { $0.brand }))
    }
    
    var availablePrices: [Double] {
        let prices = products.compactMap { $0.price }
        return Array(Set(prices)).sorted()
    }
    
    var filterableProducts: [Product] {
        self.products.filter { product in
            var matchesFilters = true
            
            if let selectedBrand = selectedBrand, !selectedBrand.isEmpty {
                matchesFilters = matchesFilters && (product.brand ?? "").lowercased() == selectedBrand.lowercased()
            }
            
            if let selectedPrice = selectedPrice {
                return product.price == selectedPrice
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
    
    
    
    
    var updatedSelectedFilterTags: [String] {
        if let selectedBrand = selectedBrand, !selectedBrand.isEmpty {
            self.selectedFilterTags.append("Brand")
        } else {
            self.selectedFilterTags.removeAll { $0 == "Brand" }
        }
        
        if let selectedPrice = selectedPrice, selectedPrice.isNaN == false {
            self.selectedFilterTags.append("Price Range")
        } else {
            self.selectedFilterTags.removeAll { $0 == "Price Range" }
        }
        
        return Array(Set(self.selectedFilterTags))
    }
    
    
    
    
}



