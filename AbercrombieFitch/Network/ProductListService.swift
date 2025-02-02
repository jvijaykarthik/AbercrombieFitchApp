//
//  ProductListService.swift
//  AbercrombieFitch
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import Foundation

protocol ProductListServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

class ProductListService: ProductListServiceProtocol {
    func fetchProducts() async throws -> [Product] {
        
        // TODO : URL should be configured based on environment
        
        let url = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.css"
        let networkMgr: NetworkManager = NetworkManager()
        if let products = try? await networkMgr.getData(url: url, type: [Product].self) {
            return products
        }
        return []
    }
}
