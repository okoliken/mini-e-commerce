//
//  BrowseView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 18/09/2025.
//

import SwiftUI

struct BrowseView: View {
    @State private var searchQuery: String = ""
    @FocusState private var isFocused: Bool
    @Environment(ProductStore.self) var store: ProductStore
    
    var categories: [Category] {
        let categories = Set(store.products.map { product in
            product.category
        })
        
        let uniqueCategories = categories.map { Category(name: $0) }
        return uniqueCategories
    }
        

    var filteredCategory: [Category] {
        if searchQuery.isEmpty {
            return categories
        } else {
            return categories.filter { product in
                product.name.lowercased().contains(searchQuery.lowercased())}
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                TextField("Search", text: $searchQuery)
                    .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 10))
                    .frame(height: 56)
                    .textInputAutocapitalization(.never)
                    .background(Color(.card))
                    .cornerRadius(12)
                    .font(.body)
                    .focused($isFocused)
                
                if searchQuery.isEmpty {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                } else {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            searchQuery = ""
                        }
                }
            }
            
            if filteredCategory.isEmpty {
                VStack {
                    Spacer()
                    
                    VStack {
                        Image("remove_14813893")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                        Text("Category not found")
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .font(.callout)
                    }
                   
                    Spacer()
                }
            }
            else {
                ScrollView(showsIndicators: false) {
                    ForEach(filteredCategory) { category in
                        NavigationLink(value: category) {
                            CategoryRow(category: category.name)
                        }
                        Divider()
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 8)
            }
            Spacer()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 8)
        .padding(.top, 24)
        
    }
}

