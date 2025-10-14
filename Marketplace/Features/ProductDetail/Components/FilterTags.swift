//
//  FilterTags.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 14/10/2025.
//
import SwiftUI

struct FilterTags: View {
    let selectedFilterTags: [String]
    let clearFilter: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(selectedFilterTags, id: \.self) { tag in
                    HStack(spacing: 6) {
                        Text(tag)
                            .font(.caption)
                        Image(systemName: "xmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                withAnimation {
                                    clearFilter(tag)
                                }
                            }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .padding(.vertical, 4)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: selectedFilterTags)
    }
}
