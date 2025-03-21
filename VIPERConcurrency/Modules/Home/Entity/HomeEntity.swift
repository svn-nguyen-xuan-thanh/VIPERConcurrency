//  
//  HomeEntity.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
}
