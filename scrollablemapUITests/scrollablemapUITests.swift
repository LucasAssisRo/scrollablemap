//
//  scrollablemapUITests.swift
//  scrollablemapUITests
//
//  Created by Lucas Assis Rodrigues on 7/9/18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import XCTest

class scrollablemapUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        XCUIDevice.shared.orientation = .portrait
        self.mapTest()
        XCUIDevice.shared.orientation = .portraitUpsideDown
        self.mapTest()
        XCUIDevice.shared.orientation = .landscapeLeft
        self.mapTest()
        XCUIDevice.shared.orientation = .landscapeRight
        self.mapTest()
    }
    
    func mapTest() {
        let scrollView = self.app.scrollViews.firstMatch
        self.scrollTest()
        scrollView.pinch(withScale: 10, velocity: 10)
        self.scrollTest()
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        scrollView.pinch(withScale: 0.1, velocity: -10)
        self.scrollTest()
    }
    
    func scrollTest() {
        let scrollView = self.app.scrollViews.firstMatch
        scrollView.swipeUp()
        scrollView.swipeDown()
        scrollView.swipeLeft()
        scrollView.swipeRight()
    }
}
