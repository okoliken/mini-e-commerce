//
//  HeaderView.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 24/10/2025.
//
import SwiftUI

struct HeaderView: View {
    let categoriesList: [String]
    @Binding var selected: String
    
    var body: some View {
        
        Text("Hello Michael")
            .font(.system(size: 32))
            .fontWeight(.semibold)
            .padding(.top, 20)
            .foregroundColor(.primary)
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 32) {
                ForEach(categoriesList, id: \.self) { category in
                    CategoryTab(category: category, selected: $selected)
                }
            }
            
        }
    }
}
