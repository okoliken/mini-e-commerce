//
//  CategoryTab.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 04/09/2025.
//

import SwiftUI

struct CategoryTab: View {
    let category: String
    @Binding var selected: String
    
    var body: some View {
        VStack(spacing: 8){
            Button(category) {
                selected = category.lowercased()
            }
            .foregroundColor(category.lowercased() == selected.lowercased() ? .black : .gray)
            .font(.callout)
            .fontWeight(.medium)
            
            Rectangle()
                .fill(category.lowercased() == selected ? .black : Color.clear)
                .frame(height: 3)
        }
    }
}

#Preview {
    CategoryTab(category: "All", selected: .constant("All"))
}
