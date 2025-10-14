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
    let clearAll: () -> Void  // Added this closure for "Clear All" action
    
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
                
                // 🧼 Clear Filters badge
                if !selectedFilterTags.isEmpty {
                    Button {
                        withAnimation {
                            clearAll()
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "trash")
                                .font(.caption2)
                            Text("Clear All")
                                .font(.caption)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .padding(.vertical, 4)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: selectedFilterTags)
    }
}
