//
//  CheckoutContent.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 12/11/2025.
//
import SwiftUI


struct CheckoutContent: View {
    var cartItems: [CartProduct]
    let shipping: Int
    let total: Double
    @Binding var isCheckoutOpen: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 96, height: 96)
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.green)
            }
            .padding(.top, 64)

            VStack(alignment: .center, spacing: 6) {
                Text("Order Confirmed")
                    .font(.title3).bold()
                    .foregroundStyle(.primary)
                Text("Thanks for your purchase! Your items are being prepared.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)

            VStack(spacing: 8) {
                HStack {
                    Text("Items")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(cartItems.count)")
                        .font(.caption)
                }
                HStack {
                    Text("Shipping")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("$\(shipping)")
                        .font(.caption)
                }
                HStack {
                    Text("Total")
                        .font(.caption).bold()
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("$\(total, specifier: "%.2f")")
                        .font(.caption).bold()
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.card))
            )
            .padding(.horizontal, 20)
            .padding(.top, 8)

            // Primary CTA
            Button(action: {
                isCheckoutOpen = false
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.white)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 20)

            Button(action: {
                isCheckoutOpen = false
            }) {
                Text("Continue Shopping")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .font(.callout)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
            .padding(.bottom, 8)

            Spacer(minLength: 0)
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
