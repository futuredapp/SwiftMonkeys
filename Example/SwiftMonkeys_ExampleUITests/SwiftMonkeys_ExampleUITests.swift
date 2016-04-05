//
//  SwiftMonkeys_ExampleUITests.swift
//  SwiftMonkeys_ExampleUITests
//
//  Created by Jakub Knejzlik on 05/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import SwiftMonkeys

class SwiftMonkeys_ExampleUITests: XCTestCase {
        
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
    
    func testManualExample() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Row 1"].tap()
        
        let uiviewNavigationBar = app.navigationBars["UIView"]
        let rootViewControllerButton = uiviewNavigationBar.buttons["Root View Controller"]
        rootViewControllerButton.tap()
        tablesQuery.staticTexts["Row 2"].tap()
        rootViewControllerButton.tap()
        tablesQuery.staticTexts["Row 3"].tap()
        app.buttons["Test button"].tap()
        uiviewNavigationBar.childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        rootViewControllerButton.tap()
        
    }
    
    func testMonkeyExample() {
        let app = XCUIApplication()
        let monkeys = SwiftMonkeys(app: app)
        monkeys.start(100)
    }
    
}
