//
//  PreviewData.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 22/10/2025.
//


import Foundation

struct Constants {
    static let fakePreviewData: [Product] = [
        .init(
            id: "1",
            title: "MacBook Air M2",
            category: "Laptops",
            price: 1199.99,
            oldPrice: 1299.99,
            productDescription: "The MacBook Air M2 redefines portability with its ultra-thin, fanless design and blazing-fast M2 chip. Enjoy a stunning Retina display, exceptional battery life, and the perfect balance of performance and efficiency for students and professionals alike.",
            imageName: "m2air-hero-6c-removebg-preview",
            model: "M2-2023",
            brand: "Apple",
            year: 2023
        ),
        .init(
            id: "7",
            title: "iPhone 14 Pro",
            category: "Smartphones",
            price: 999.99,
            oldPrice: 1099.99,
            productDescription: "Apple’s flagship iPhone 14 Pro introduces the Dynamic Island, a 48MP Pro camera system, and the cutting-edge A16 Bionic chip. With ProMotion display and advanced safety features like Crash Detection, it’s the most complete iPhone yet.",
            imageName: "11695042077oesbaga8u99nivryc9nzarbrxlvtxo75hktgifqitudaoqxyj1lxhtu3tkcvxpffnvfv0dkit6lsj5b1jx4zi5olqyigm0vcjner-removebg-preview",
            model: "iPhone14Pro",
            brand: "Apple",
            year: 2023
        ),
        .init(
            id: "14",
            title: "Sony WH-1000XM5",
            category: "Headphones",
            price: 399.99,
            oldPrice: 449.99,
            productDescription: "Sony’s WH-1000XM5 headphones deliver unmatched noise cancellation and premium sound. With 30 hours of battery life, lightweight design, and adaptive sound control, they’re built for both travel and everyday listening.",
            imageName: "2500x2500_Silver_9-removebg-preview",
            model: "WH1000XM5",
            brand: "Sony",
            year: 2023
        ),
        .init(
            id: "15",
            title: "Apple AirPods Pro (2nd Gen)",
            category: "Earphones",
            price: 249.99,
            oldPrice: 279.99,
            productDescription: "The AirPods Pro 2 bring immersive sound with Adaptive Transparency, Active Noise Cancellation, and personalized spatial audio. Compact and comfortable, they seamlessly integrate with Apple devices for effortless use.",
            imageName: "png-transparent-airpods-thumbnail-removebg-preview",
            model: "AirPodsPro2",
            brand: "Apple",
            year: 2023
        ),
        .init(
            id: "20",
            title: "Logitech MX Master 3S",
            category: "Accessories",
            price: 99.99,
            oldPrice: 119.99,
            productDescription: "The MX Master 3S is Logitech’s flagship productivity mouse, offering precision tracking, customizable buttons, and ergonomic comfort. Its MagSpeed scroll wheel lets you fly through documents and timelines with ease.",
            imageName: "378-3780134_mac-logitech-mx-master-3-hd-png-download-removebg-preview",
            model: "MXMaster3S",
            brand: "Logitech",
            year: 2023
        )
    ]
    
    static let dealsOfTheDay: [Product] = [
        Product(
            id: UUID().uuidString,
            title: "Galaxy SmartWatch",
            category: "Wearables",
            price: 249.99,
            oldPrice: 299.99,
            productDescription: "Fitness tracking, notifications, and health monitoring",
            imageName: "smartwatch",
            model: "Model: WH-1000XM4, Black",
            brand: "Samsung",
            year: 2022
        ),
        Product(
            id: UUID().uuidString,
            title: "RØDE PodMic",
            category: "Microphones",
            price: 108.20,
            oldPrice: 199.99,
            productDescription: "Dynamic microphone, Speaker microphone",
            imageName: "rodemicrophone",
            model: "Model: WH-1000XM4, Black",
            brand: "LG",
            year: 2022
        ),
        Product(
            id: UUID().uuidString,
            title: "SONY Premium Headphones",
            category: "Smartphones",
            price: 699.00,
            oldPrice: 799.00,
            productDescription: "High-performance smartphone with advanced camera system",
            imageName: "headphones",
            model: "Model: WH-1000XM4, Black",
            brand: "Sony",
            year: 2022
        )
    ]
}
