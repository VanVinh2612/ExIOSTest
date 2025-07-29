//
//  Product.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

struct Product {
    let id: Int
    let name: String
    let description: String
    let whatIOfferItems : [String]
    let images: [Item]
    let thumbnailImage: String
}

struct Item {
    let image: String
    let price: String
}
