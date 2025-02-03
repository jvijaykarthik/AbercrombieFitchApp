//
//  Product.swift
//  AbercrombieFitch
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import Foundation

struct Product: Codable, Hashable {
    let title: String
    let backgroundImage: String
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
    let content: [Content]?
}

struct Content: Codable, Hashable {
    let title: String
    let target: String
    let elementType: String?
}
