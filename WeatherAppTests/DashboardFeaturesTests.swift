//

import XCTest
@testable import WeatherApp

final class DashboardFeaturesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListOfCitiesThatPatternMatched() {
        
    }
    
    func testListOfCitiesBasedOnUserInput() {
        
    }
    
    func testIsWeatherImageExist() {
        
    }
    
    func testIsWeatherHumidityExist() {
        
    }
    
    func testIsWeatherDescriptionExist() {
        
    }
    
    func testIsWeatherTemperatureExist() {
        
    }
    
    func testCitiesNotViewedByUser() {
        
    }
    
    func testRecentCitiesViewedByUser() {
        
    }
    
    func testRecentTenCitiesViewedByUser() {
        
    }
    
    func testFetchWeatherDataFailure() {
        var mockService = MockServices()
        mockService.result = .failure(.decodingError("Error"))
        var sut = DashboardViewModel()
        sut.fetchWeatherData()
        
        XCTAssertTrue(sut.weather!.data.request.isEmpty)
    }
    
    func testFetchWeatherDataSuccess() {
        var mockService = MockServices()
        var sut = DashboardViewModel()
        sut.fetchWeatherData()
        
        XCTAssertTrue(sut.weather!.data.request.isEmpty)
    }
    
    

}
