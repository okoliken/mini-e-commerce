//
//  BrowseListView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 26/09/2025.
//

import SwiftUI

struct BrowseListView: View {
    @State var showingFilters = false
    @StateObject var viewModel: BrowseListViewModel
    @Environment(\.dismiss) private var dismiss
    
    let category: Category
    let products: [Product]
    
    init(category: Category, products: [Product]) {
        self.category = category
        self.products = products
        _viewModel = StateObject(wrappedValue: BrowseListViewModel(products: products))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                FilterListContainer(
                    brands: viewModel.productBrands,
                    showingFilters: $showingFilters,
                    selectedBrand: $viewModel.selectedBrand,
                    selectedPrice: $viewModel.selectedPrice,
                    availablePrices: viewModel.availablePrices
                )
                if viewModel.selectedFilterTags.count > 0 {
                    FilterTags(selectedFilterTags: viewModel.selectedFilterTags) { tag in
                        viewModel.clearFilter(tag)
                    }
                }
                VStack {
                    SortByRelevance(
                        productsCount: products.count,
                        sortText: "Sort by",
                        relevanceText: "Relevance",
                        options: SortOption.allCases
                    ) { sortOrder in
                        if let convertedEnumSortOrder = SortOption(rawValue: sortOrder) {
                            withAnimation(.easeInOut(duration: 0.4)){
                                viewModel.selectedSortOption = convertedEnumSortOrder
                            }
                        }
                    }
                    
                    ProductGrid(
                        productList: viewModel.sortedProducts,
                        columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ])
                }
            }
            .navigationToolbarModifier(title: category.name, backPath: {dismiss()})
            .padding(.horizontal, 20)
        }
    }
}

