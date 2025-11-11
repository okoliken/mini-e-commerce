//
//  FilterListContainer.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 11/10/2025.
//

import SwiftUI

struct FilterListContainer: View {
    let brands: [String]
    let models: [String]
    @State private var showingSheet = false
    
    @Binding var showingFilters: Bool
    @Binding var selectedBrand: String?
    @Binding var selectedPrice: String?
    @Binding var selectedModel: String?
    @Binding var selectedYear: String?
    
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterButton(showingSheet: $showingSheet, selectedPrice: $selectedPrice)
                MenuSelector(
                    label: "Brand",
                    options: brands,
                    selectedOption: selectedBrand
                ) { brand in
                    selectedBrand = brand
                }
                
                MenuSelector(
                    label: "Year",
                    options: [
                        "2019",
                        "2020",
                        "2021",
                        "2022",
                        "2023"
                    ],
                    selectedOption: selectedYear
                ) { year in
                    selectedYear = year
                }
                
                MenuSelector(
                    label: "Model",
                    options: models,
                    selectedOption: selectedModel
                ) { model in
                    selectedModel = model
                }
                
                MenuSelector(
                    label: "Offers",
                    options: [],
                    selectedOption: ""
                ) { model in
                    selectedModel = model
                }
                
            }
        }
        .padding(.top, 15)
        .scrollTargetBehavior(.paging)
    }
}

struct FilterButton: View {
    @Binding var showingSheet: Bool
    @Binding var selectedPrice: String?
    
    var body: some View {
        Button(action: {showingSheet = true}) {
            Image("filter")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
        }
        
        .frame(width: 44, height: 40)
        .background(Color(.card))
        .cornerRadius(12)
        .contentShape(Rectangle())
        
        .sheet(isPresented: $showingSheet) {
            PriceFilterSheet(selectedPrice: $selectedPrice)
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.visible)
        }
    }
}


struct PriceFilterSheet: View {
    @Binding var selectedPrice: String?
    @State private var selectedPriceRange: String?
    
    let priceRanges = [
        "$50 - $99",
        "$100 - $199",
        "$200 - $399",
        "$400 - $699",
        "$700 - $999",
        "$1000 - $1499",
        "$1500 - $1999"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Filter by Price")
                .font(.system(.body, design: .rounded))
                .fontWeight(.medium)
                .padding(.top, 25)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 120), spacing: 12)],
                    spacing: 12
                ) {
                    ForEach(priceRanges, id: \.self) { range in
                        let isSelected = selectedPriceRange == range
                        
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedPriceRange = range
                                selectedPrice = range
                            }
                        } label: {
                            Text(range)
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.card))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isSelected ? Color.black : Color.card, lineWidth: isSelected ? 2 : 1)
                                )
                                .foregroundStyle(.primary)
                                .scaleEffect(isSelected ? 1.03 : 1.0)
                                .shadow(color: isSelected ? Color.black.opacity(0.2) : .clear, radius: 4, y: 2)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .padding(.bottom, 12)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}
