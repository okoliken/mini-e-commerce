//
//  SortByRelevance.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 11/10/2025.
//

import SwiftUI

struct SortByRelevance: View {
    let productsCount: Int
    let sortText: String
    let relevanceText: String
    let options: [SortOption]
    let onSelect: (String) -> Void
    
    var body: some View {
        HStack() {
            Text("\(productsCount) products")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .opacity(0.4)
            
            Spacer()
            
            Menu {
                ForEach(options.map {$0.rawValue}, id: \.self) { option in
                    Button(option) {
                        onSelect(option)
                    }
                }
            } label: {
                HStack(spacing: 2){
                    Text("\(sortText)")
                        .font(.caption)
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                    HStack(spacing: 4){
                        
                        Text("\(relevanceText)")
                            .font(.caption)
                            .fontWeight(.bold)
                        
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.black)
                            .font(.caption)
                    }
                }
            }
        }
    }
}


