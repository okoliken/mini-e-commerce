//
//  MenuSelector.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 11/10/2025.
//

import SwiftUI

struct MenuSelector: View {
    let label: String
    let options: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option) {
                    onSelect(option)
                }
            }
        } label: {
            HStack {
                Text(label)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(height: 40)
            .background(Color(.card))
            .cornerRadius(12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
