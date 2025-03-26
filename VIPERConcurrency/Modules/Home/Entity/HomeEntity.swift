//  
//  HomeEntity.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import GRDB

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
}

extension Product: TableRecord, FetchableRecord, PersistableRecord {
    static var databaseTableName: String {
        return "products"
    }
}
