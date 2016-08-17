//
//  DemoProductUITests.swift
//  DemoProductUITests
//
//  Created by YANGSHENG ZOU on 2016-08-11.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import XCTest

class DemoProductUITests: XCTestCase {
        
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
        
        let app = XCUIApplication()
        app.buttons[">"].tap()
        
        let introScreenImg2PngImage = app.images["intro-screen-img-2.png"]
        introScreenImg2PngImage.tap()
        
        let doneButton = app.buttons["DONE"]
        doneButton.tap()
        app.searchFields["Input city name"].tap()
        app.searchFields["Input city name"]
        
        let app2 = app
        app2.tables.staticTexts["Ottawa ON"].tap()
        app2.pickerWheels["Bushel"].tap()
        app.buttons["okay"].tap()
        
        let introScreenImg3PngImage = app2.images["intro-screen-img-3.png"]
        introScreenImg3PngImage.tap()
        introScreenImg2PngImage.tap()
        introScreenImg3PngImage.tap()
        doneButton.tap()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
