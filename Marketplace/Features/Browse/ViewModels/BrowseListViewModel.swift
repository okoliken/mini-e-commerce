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

struct PriceRange {
    let label: String
    let min: Double
    let max: Double
}

let priceRanges: [PriceRange] = [
    .init(label: "$50 - $99", min: 50, max: 99),
    .init(label: "$100 - $199", min: 100, max: 199),
    .init(label: "$200 - $399", min: 200, max: 399),
    .init(label: "$400 - $699", min: 400, max: 699),
    .init(label: "$700 - $999", min: 700, max: 999),
    .init(label: "$1000 - $1499", min: 1000, max: 1499),
    .init(label: "$1500 - $1999", min: 1500, max: 1999)
]


public class BrowseListViewModel: ObservableObject {
    @Published var selectedFilterTags: [String] = []
    @Published var products: [Product] = []
    
    @Published var selectedBrand: String? = nil {
        didSet {
            self.updateFilterTags()
        }
    }
    @Published var selectedPrice: String? {
        didSet {
            self.updateFilterTags()
        }
    }
    @Published var selectedYear: String? {
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
        
        if let selectedPrice = self.selectedPrice, !selectedPrice.isEmpty {
            filterTags.append("Price")
        }
        
        if let selectedModel = self.selectedModel, !selectedModel.isEmpty {
            filterTags.append("Model")
        }
        
        if self.selectedYear != nil {
            filterTags.append("Year")
        }
        
        self.selectedFilterTags = filterTags
    }
    
    
    var productBrands: [String] {
        Array(Set(self.products.compactMap { $0.brand }))
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
            
            if let selectedPrice = self.selectedPrice, let range = priceRanges.first(where: { $0.label == selectedPrice }) {
                matchesFilters = matchesFilters && (product.price >= range.min && product.price <= range.max)
            }
            
            if let selectedYear = self.selectedYear, !selectedYear.isEmpty {
                matchesFilters = matchesFilters && (product.year == Int(selectedYear))
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
        self.selectedYear = nil
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
        case "year":
            self.selectedYear = nil
        default:
            break
        }
        
        self.selectedFilterTags.removeAll { $0.lowercased() == tag.lowercased() }
    }
    
}



