//

import XCTest

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testNavigationFromHomeToDetailScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchSearchField = app.navigationBars["Weather App"].searchFields["Search"]
        searchSearchField.tap()
        app.tables.cells.children(matching: .other).element(boundBy: 1).tap()
        app.navigationBars["Singapore, Singapore"].buttons["Back"].tap()
        searchSearchField.tap()
                
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
