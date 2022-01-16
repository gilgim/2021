//
//  KimWooJin_CodingTestUITests.swift
//  KimWooJin_CodingTestUITests
//
//  Created by KimWooJin on 2022/01/16.
//

import XCTest

class KimWooJin_CodingTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
		let app = XCUIApplication()
		basicViewFuc(app: app)
		//customViewFuc(app: app)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
	
	//	과제 뷰 테스트
	func basicViewFuc(app:XCUIApplication){
		app.launch()
		
		app.textFields["금액"].tap()
		
		let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key.tap()
		
		let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key2.tap()
		
		let key3 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key3.tap()
		
		let key4 = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key4.tap()
		
		app.toolbars["Toolbar"].buttons["Done"].tap()
		
		sleep(3)
		
		app.staticTexts["selectCountry"].tap()
		let selectcountryStaticText = app.staticTexts["selectCountry"]
		selectcountryStaticText.tap()
		
		let krwPickerWheel = app/*@START_MENU_TOKEN@*/.pickerWheels["한국(KRW)"]/*[[".pickers[\"countryPicker\"].pickerWheels[\"한국(KRW)\"]",".pickers[\"KeyboardPicker\"].pickerWheels[\"한국(KRW)\"]",".pickerWheels[\"한국(KRW)\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		krwPickerWheel.swipeUp()
		XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["KeyboardPicker"]/*[[".buttons[\"Done\"]",".buttons[\"KeyboardPicker\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		sleep(3)
	}
	
	//	커스텀 뷰 테스트
	func customViewFuc(app:XCUIApplication){
		app.launch()

		app.textFields["금액"].tap()
		
		let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key.tap()
		
		let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key2.tap()
		
		let key3 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key3.tap()
		
		let key4 = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		key4.tap()
		app.toolbars["Toolbar"].buttons["Done"].tap()
		
		sleep(2)
		
		app.buttons["한국(KRW)"].tap()
		app.collectionViews/*@START_MENU_TOKEN@*/.buttons["필리핀(PHP)"]/*[[".cells.buttons[\"필리핀(PHP)\"]",".buttons[\"필리핀(PHP)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		sleep(2)
	}
}
