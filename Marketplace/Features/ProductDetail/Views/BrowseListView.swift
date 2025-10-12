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
                if viewModel.updatedSelectedFilterTags.count > 0 {
                    HStack {
                        Text("Filters:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack(spacing: 8) {
                            ForEach(viewModel.updatedSelectedFilterTags, id:\.self) { tag in
                                HStack {
                                    Text(tag)
                                        .font(.caption)
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            print("Clear Price range filter")
                                        }
                                }
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color(.card))
                                .cornerRadius(10)
                            }
                        }
                        Spacer()
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
                            withAnimation(.easeInOut(duration: 0.3)){
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

