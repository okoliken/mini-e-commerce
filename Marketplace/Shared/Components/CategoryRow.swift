//
//  CategoryRow.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 19/09/2025.
//

import SwiftUI

struct CategoryRow: View {
    let category: String
    
    var body: some View {
        HStack {
            Text(category)
                .font(.title3)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.primary)
                .font(.body)
        }
        .padding(.vertical, 12)
        .background(Color.clear)

    }
}
