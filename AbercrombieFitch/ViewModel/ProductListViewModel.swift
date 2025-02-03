//
//  ProductListViewModel.swift
//  AbercrombieFitch
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String?

    let service: ProductListServiceProtocol

    init(service: ProductListServiceProtocol) {
        self.service = service
    }

    @MainActor
    func fetchProducts() async {
        do {
            let fetchedProducts = try await service.fetchProducts()
            self.products = fetchedProducts
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
