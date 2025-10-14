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
    let availablePrices: [String: Double]
    
    @Binding var showingFilters: Bool
    @Binding var selectedBrand: String?
    @Binding var selectedPrice: Double?
    @Binding var selectedModel: String?
    @State private var showingSheet = false

    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterButton(showingSheet: $showingSheet)
                MenuSelector(label: "Brand", options: brands, selectedOption: selectedBrand) { brand in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedBrand = brand
                    }
                }
                MenuSelector(label: "Price", options: Array(availablePrices.keys), selectedOption: "") { selected in
                    print("Selected category: \(selected)")
                }
                
                MenuSelector(label: "Offers", options: ["Under $100", "$100 – $500", "Above $500"], selectedOption: "") { selected in
                    print("Selected category: \(selected)")
                }
                MenuSelector(label: "Model", options: models, selectedOption: selectedModel) { model in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedModel = model
                    }
                }
            }
        }
        .padding(.top, 15)
        .scrollTargetBehavior(.paging)
    }
}

struct FilterButton: View {
    @Binding var showingSheet: Bool
    
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
            FiltersComingSoonView()
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.visible)
        }
    }
}


struct FiltersComingSoonView: View {
    var body: some View {
        VStack {
            Image("remove_14813893")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("More filter options coming soon")
                .font(.body)
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
           
        }
    }
}
