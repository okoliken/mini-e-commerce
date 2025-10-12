//
//  FilterListContainer.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 11/10/2025.
//

import SwiftUI

struct FilterListContainer: View {
    let brands: [String]
    @Binding var showingFilters: Bool
    @Binding var selectedBrand: String?
    @Binding var selectedPrice: Double?
    var availablePrices: [Double]?
//    var priceRange: [ClosedRange<Double>]?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                
                MenuSelector(label: "Brand", options: brands) { brand in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedBrand = brand
                    }
                }
                
                MenuSelector(label: "Category", options: ["Audio", "Gaming", "Smartphones"]) { selected in
                    print("Selected category: \(selected)")
                }
                

                MenuSelector(label: "Offers", options: ["Under $100", "$100 – $500", "Above $500"]) { selected in
                    print("Selected category: \(selected)")
                }
                MenuSelector(label: "Model", options: ["Under $100", "$100 – $500", "Above $500"]) { model in
                    print("met this condition")
                }
            }
        }
        .padding(.top, 15)
    }
}
