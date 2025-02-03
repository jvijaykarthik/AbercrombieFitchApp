//
//  ProductListView.swift
//  AbercrombieFitch
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject var viewModel: ProductListViewModel = ProductListViewModel(service: ProductListService())

    var body: some View {
        List {
            ForEach(viewModel.products, id: \.self) { product in
                ProductView(product: product)
                .listRowSeparator(.hidden)
            }
        }.task {
            await viewModel.fetchProducts()
        }.refreshable {
            await viewModel.fetchProducts()
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea([.leading, .bottom])
        .listStyle(GroupedListStyle())
    }
}

#Preview {
    ProductListView()
}
