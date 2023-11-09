//
//  KalculatorTests.swift
//  KalculatorTests
//
//  Created by Adil Saleem on 31/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.
//

import XCTest
@testable import Kalculator

final class KalculatorTests: XCTestCase {
    
    var calculator: Calculator!
    
    var viewController: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        calculator = Calculator()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        _ = viewController.view // Load the view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculator = nil
        super.tearDown()
    }
    
    func testAddtionPositive() {
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.add)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "5")
    }
    
    func testAdditionNegative() {
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.add)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "4")
    }
    
    func testSubtractionPositive() {
        try? calculator.inputDigit("5")
        try? calculator.performOperation(.subtract)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "2")
    }
    
    func testSubtractionNegative() {
        try? calculator.inputDigit("5")
        try? calculator.performOperation(.subtract)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "5")
    }
    
    func testMultiplicationPositive() {
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.multiply)
        try? calculator.inputDigit("5")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "15")
    }
    
    func testMultiplicationNegative() {
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.multiply)
        try? calculator.inputDigit("5")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "8")
    }
    
    func testDivisionPositive() {
        try? calculator.inputDigit("4")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "2")
    }
    
    func testDivisionNegative() {
        try? calculator.inputDigit("4")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "0")
    }
    
    func testClearPostive() {
        try? calculator.inputDigit("786")
        calculator.clear()
        XCTAssertEqual(try? calculator.inputDigit("="), "0")
    }
    
    func testClearNegative() {
        calculator.clear()
        XCTAssertNotEqual(try? calculator.inputDigit("="), "")
    }
    
    func testDivisionByZero() {
        try? calculator.inputDigit("1")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("0")
        XCTAssertThrowsError(try calculator.performOperation(.equals)) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.illegalOperation)
        }
    }
    
    func testInputDigitNegative() {
        XCTAssertThrowsError(try calculator.inputDigit("a")) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.invalidDigit)
        }
    }
    
    func testInputDigitPositive() {
        let result = try? calculator.inputDigit("1")
        XCTAssertEqual(result, "1")
    }
    
    func testAppendPositive() {
        try? calculator.appendDigit("1")
        try? calculator.appendDigit("2")
        try? calculator.appendDigit("3")
        
        XCTAssertEqual(try? calculator.inputDigit("="), "123")
    }
    
    func testAppendNegative() {
        try? calculator.appendDigit("1")
        XCTAssertThrowsError(try calculator.inputDigit("12abc")) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.invalidDigit)
        }
    }
    
    func testInputDigit() {
        // Given
        let digitButton = UIButton()
        digitButton.setTitle("1", for: .normal)
        
        // When
        viewController.inputDigit(digitButton)
        
        // Then
        XCTAssertEqual(viewController.resultScreen.text, "1")
    }
    
    func testClearOfViewController() {
        // Given
        viewController.resultScreen.text = "111"
        
        // When
        viewController.clear(UIButton())
        
        // Then
        XCTAssertEqual(viewController.resultScreen.text, "0")
    }
    
    func testInputInvalidDigit() {
        // Given
        let invalidDigitButton = UIButton()
        invalidDigitButton.setTitle("Hello", for: .normal)
        
        // When
        viewController.inputDigit(invalidDigitButton)
        
        // Then
        XCTAssertEqual(viewController.resultScreen.text, "Err")
    }
    

}



