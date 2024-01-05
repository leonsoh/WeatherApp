//

import XCTest
@testable import WeatherApp

final class DashboardFeaturesTests: XCTestCase {
    
    let mockService = MockServices()
    var sut = DashboardViewModel()
    
    override func setUp() {
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                sut.getCityData(data: weatherData)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: DataPersistence.CITY_VIEWED_KEY)
        UserDefaults.standard.synchronize()
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
        
    //MARK: - Fetch Weather Data
    func testFetchWeatherDataSuccess() {
        sut.fetchWeatherData()
        XCTAssertNotNil(sut.cityData)
    }
    
    func testFetchWeatherDataViewedByUserSuccess() {
        sut.fetchWeatherDataViewedByUser()
        testFetchWeatherDataViewedByUser()
        
        XCTAssertNotNil(sut.citiesViewedByUser)
        XCTAssertNil(sut.onErrorMessage)
    }
    
    func testFetchWeatherDataViewedByUserFailure() {
        sut.fetchWeatherDataViewedByUser()
        
        XCTAssertNotNil(sut.citiesViewedByUser)
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
    
    func testDisplayTenRecentViewedCities() {
        //Fetch more than 10 count
        testFetchElevenWeatherDataViewedByUser()
        
        XCTAssertEqual(sut.displayTenRecentCities(), 10)
    }
    
    func testDisplayRecentViewedCities() {
        testFetchWeatherDataViewedByUser()
        let recentCitiesCount = sut.citiesViewedByUser.count
        XCTAssertEqual(recentCitiesCount, 1)
    }
    
    //MARK: - SearchController
    func testUpdateSearchController() {
        let searchBarText = "Singapore"
        sut.updateSearchController(searchBarText: searchBarText)
        let searchText = sut.filteredCities[0].data.request[0].name
        XCTAssertTrue(searchText.contains(searchBarText))
    }

}
extension DashboardFeaturesTests {
    func testFetchElevenWeatherDataViewedByUser() {
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                
                for _ in 1...11 {
                    sut.getCitiesViewedByUser(data: weatherData)
                }
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testFetchWeatherDataViewedByUser() {
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                sut.getCitiesViewedByUser(data: weatherData)
                
            } catch let error {
                print(error)
            }
        }
    }
}
