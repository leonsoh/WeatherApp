//

import XCTest
@testable import WeatherApp

final class DashboardFeaturesTests: XCTestCase {
    
    var sut: DashboardViewModel!
    
    override func setUp() {
        let mockService = MockServices()
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                sut = DashboardViewModel()
                sut.getCityData(data: weatherData)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testIsWeatherImageExist() {
        let weatherImage = sut.cityData[0].data.currentCondition[0].weatherIconURL[0].value
        XCTAssertTrue(!weatherImage.isEmpty)
        
    }
    
    func testIsWeatherHumidityExist() {
        let humidity = sut.cityData[0].data.currentCondition[0].humidity
        XCTAssertTrue(!humidity.isEmpty)
    }
    
    func testIsWeatherDescriptionExist() {
        let weatherDesc = sut.cityData[0].data.currentCondition[0].weatherDesc[0].value
        XCTAssertTrue(!weatherDesc.isEmpty)
    }
    
    func testIsWeatherTemperatureExist() {
        let temp = sut.cityData[0].data.currentCondition[0].tempC
        XCTAssertTrue(!temp.isEmpty)
    }
    
    func testFetchWeatherDataFailure() {
        let mockService = MockServices()
        mockService.result = .failure(.decodingError("Error"))
        let sut = DashboardViewModel()
        sut.fetchWeatherData()
        
        XCTAssertTrue(sut.cityData.isEmpty)
    }
    
    func testFetchWeatherDataSuccess() {
        let mockService = MockServices()
        
        mockService.result = .success(sut.cityData[0])
        XCTAssertNotNil(mockService.result)
    }
    
    func testSavedListOfCitiesSuccess() {
        let cities = CityList.cities
        UserDefaults.standard.set(cities, forKey: DataPersistence.CITY_VIEWED_KEY)
        
        XCTAssertEqual(UserDefaults.standard.stringArray(forKey: DataPersistence.CITY_VIEWED_KEY), cities)
    }
    
    func testDisplayNoRecentViewedCities() {
        let recentCitiesCount = sut.displayTenRecentCities()
        
        XCTAssertEqual(recentCitiesCount, 0)
    }
    
    func testDisplayRecentViewedCities() {
        
        let mockService = MockServices()
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                sut = DashboardViewModel()
                let cityViewed = sut.getCitiesViewedByUser(data: weatherData)
                
                
                
            } catch let error {
                print(error)
            }
        }
        
        let recentCitiesCount = sut.displayTenRecentCities()
        XCTAssertEqual(recentCitiesCount, 1)
    }
    
//    func testInSearchMode() {
//        let vc = DashboardViewController()
//        let searchMode = UISearchController(searchResultsController: vc)
//        
//        //XCTAssertTrue(isSearchMode)
//    }
}
