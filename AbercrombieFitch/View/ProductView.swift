//
//  ProductView.swift
//  AbercrombieFitch
//
//  Created by Vijay Karthik Jeyaraj on 2/2/25.
//
import SwiftUI

struct ProductView: View {
    let product: Product
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading) {
            // Background Image
            // TODO Cache image for better performance
            AsyncImage(url: URL(string: product.backgroundImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            .accessibilityIdentifier("backgroundImage")
            Spacer().frame(height: 10)
            // Top Description
            if let topDescription = product.topDescription {
                Text(topDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityIdentifier("topDescription")
                    .dynamicTypeSize(.small ... .accessibility1)
            }
            Spacer().frame(height: 5)
            // Title
            Text(product.title)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .accessibilityIdentifier("productTitle")
                .dynamicTypeSize(.small ... .accessibility1) // Adapts to accessibility sizes
                .minimumScaleFactor(0.7)

            if let contents = product.content, contents.count > 0 {
                ForEach(contents, id: \.self) { content in
                    HStack {
                        Button(action: {
                            if let url = URL(string: content.target) {
                                openURL(url)
                            }
                        }) {
                            Text(content.title.uppercased())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .border(.black)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                        .accessibilityIdentifier("button_\(content.title)")
                        .dynamicTypeSize(.small ... .accessibility1)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            Spacer().frame(height: 10)
        }
    }
}
