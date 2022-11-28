//
//  MovieSearchUITests.swift
//  MovieSearchUITests
//
//  Created by James Buckley on 27/11/2022.
//

import XCTest

final class MovieSearchUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ContentView_searchButton_shouldNavigateToListView() {
        app/*@START_MENU_TOKEN@*/.textFields["SearchTextField"]/*[[".textFields[\"Search\"]",".textFields[\"SearchTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
     
        app/*@START_MENU_TOKEN@*/.buttons["SearchButton"]/*[[".buttons[\"Search\"]",".buttons[\"SearchButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let navBar = app.navigationBars["Results"]
        XCTAssertTrue(navBar.exists)
    }
    
    func test_ContentView_searchButton_shouldNotNavigateToListView() {
        app/*@START_MENU_TOKEN@*/.textFields["SearchTextField"]/*[[".textFields[\"Search\"]",".textFields[\"SearchTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["SearchButton"]/*[[".buttons[\"Search\"]",".buttons[\"SearchButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let navBar = app.navigationBars["Results"]
        XCTAssertTrue(!navBar.exists)
    }
}
