//
//  AbercrombieFitchUITests.swift
//  AbercrombieFitchUITests
//
//  Created by Vijay Karthik Jeyaraj on 2/1/25.
//

import XCTest

final class AbercrombieFitchUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductViewUI() {
        // Check if title exists
        let title = app.staticTexts["productTitle"]
        XCTAssertTrue(title.exists, "Product title should be visible")
        
        // Check if description exists
        let topDescription = app.staticTexts["topDescription"]
        XCTAssertTrue(topDescription.exists, "Top description should be visible")
        
        // Check if background image exists
        let backgroundImage = app.images["backgroundImage"]
        XCTAssertTrue(backgroundImage.exists, "Background image should be visible")
        
        // Verify button interactions
        let button = app.buttons["button_Shop Men"] // Change based on content title
        XCTAssertTrue(button.exists, "Buy Now button should be visible")
        button.tap()
    }

    func testScrollingInList() {
        let tableView = app.tables.firstMatch
        
        XCTAssertTrue(tableView.waitForExistence(timeout: 10), "List (UITableView) should exist")

        // Perform scrolling gestures
        tableView.swipeUp()
        tableView.swipeDown()
    }

    func testDynamicFontScaling() {
        let title = app.staticTexts["productTitle"]
        XCTAssertTrue(title.exists, "Product title should be visible")
        
        // Simulate increased font size
        app.adjustTextSizeToLarger()
        XCTAssertTrue(title.exists, "Product title should be visible after font size increase")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

// Utility function to adjust text size for accessibility
extension XCUIApplication {
    func adjustTextSizeToLarger() {
        self.launchArguments.append("UIAccessibilityTextSizeLarger")
        self.launch()
    }
}
