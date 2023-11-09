//
//  KalculatorUITests.swift
//  KalculatorUITests
//
//  Created by Adil Saleem on 31/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.
//

import XCTest

final class KalculatorUITests: XCTestCase {

    var app:XCUIApplication?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // UI tests must launch the application that they test
        
        let app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testButtonsExist() throws {
        for i in 0...9 {
            XCTAssertNotNil(app?.buttons["\(i)"], "Number button \(i) is missing.")
        }
    
        let operators = ["+", "-", "*", "/", "="]
        for operatorSymbol in operators {
            XCTAssertNotNil(app?.buttons[operatorSymbol], "Operator button '\(operatorSymbol)' is missing.")
        }
    }
    
    func testOutputDisplay() {
        // Input numbers and operators
        
        app?.buttons["2"].tap()
        app?.buttons["+"].tap()
        app?.buttons["2"].tap()
        app?.buttons["="].tap()
        
        // Verify the result is displayed
        let resultLabel = app?.staticTexts["result"]
        XCTAssertEqual(resultLabel?.label, "9", "Result is not displayed as expected")

        // Input invalid input to trigger an error
        app?.buttons["/"].tap()
        app?.buttons["0"].tap()
        app?.buttons["="].tap()

        // Verify the error is displayed
        let errorLabel = app?.staticTexts["result"]
        XCTAssertEqual(errorLabel?.label, "Err", "Result is not displayed as expected")
    }

}
