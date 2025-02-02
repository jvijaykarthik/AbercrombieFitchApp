//
//  MockProductListService.swift
//  AbercrombieFitchTests
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import Foundation
@testable import AbercrombieFitch

class MockProductListService: ProductListServiceProtocol {
    func fetchProducts() async throws -> [AbercrombieFitch.Product] {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        } else {
            return [
                Product(title: "Product 1", backgroundImage: "https://example.com/image1.jpg", promoMessage: "Promo 1", topDescription: "Top 1", bottomDescription: "Bottom 1", content: nil),
                Product(title: "Product 2", backgroundImage: "https://example.com/image2.jpg", promoMessage: nil, topDescription: "Top 2", bottomDescription: "Bottom 2", content: nil)
            ]
        }
    }
    
    var shouldReturnError = false

}
