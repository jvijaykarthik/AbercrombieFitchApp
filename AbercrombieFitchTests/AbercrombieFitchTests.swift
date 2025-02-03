//
//  AbercrombieFitchTests.swift
//  AbercrombieFitchTests
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import XCTest
@testable import AbercrombieFitch

final class AbercrombieFitchTests: XCTestCase {
    
    var viewModel: ProductListViewModel!
    var mockService: MockProductListService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockService = MockProductListService()
        viewModel = ProductListViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchProducts_Success() async {
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 2, "Expected 2 products")
        XCTAssertEqual(viewModel.products.first?.title, "Product 1", "First product title should match")
    }

    func testFetchProducts_Failure() async {
        mockService.shouldReturnError = true

        await viewModel.fetchProducts()

        XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil")
    }
    
    func testProductContent() async {
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products[1].content?.count, 1, "Expected 1 content")
        XCTAssertEqual(viewModel.products[1].content?[0].target, "https://abercrombie.com", "First content target should match")
        if let contentTargetURLString = viewModel.products[1].content?[0].target {
            XCTAssertTrue(isValidURL(contentTargetURLString))
        }
    }
    
    func testBackgroungImageIsValidURL() async {
        await viewModel.fetchProducts()
        
        if let imageURLString = viewModel.products.first?.backgroundImage {
            XCTAssertTrue(isValidURL(imageURLString))
        }
        XCTAssertFalse(isValidURL(viewModel.products[1].backgroundImage))
    }

    func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}
