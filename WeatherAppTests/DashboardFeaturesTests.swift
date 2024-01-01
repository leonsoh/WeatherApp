//

import XCTest
@testable import WeatherApp

final class DashboardFeaturesTests: XCTestCase {
    let mockService = MockServices()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsWeatherImageExist() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let weatherImage = weatherData.data.currentCondition[0].weatherIconURL[0].value
                XCTAssertTrue(!weatherImage.isEmpty)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testIsWeatherHumidityExist() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let humidity = weatherData.data.currentCondition[0].humidity
                XCTAssertTrue(!humidity.isEmpty)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testIsWeatherDescriptionExist() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let weatherDesc = weatherData.data.currentCondition[0].weatherDesc[0].value
                XCTAssertTrue(!weatherDesc.isEmpty)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testIsWeatherTemperatureExist() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let temp = weatherData.data.currentCondition[0].tempC
                XCTAssertTrue(!temp.isEmpty)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testFetchWeatherDataFailure() {
        mockService.result = .failure(.decodingError("Error"))
        let sut = DashboardViewModel()
        sut.fetchWeatherData()
        
        XCTAssertTrue(sut.cityData.isEmpty)
    }
    
    func testFetchWeatherDataSuccess() {
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
               
                mockService.result = .success(weatherData)
    
                XCTAssertNotNil(mockService.result)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testSavedListOfCitiesSuccess() {
        let cities = CityList.cities
        DataPersistence.shared.saveListOfCitiesViewed(array: cities)
     
        XCTAssertEqual(DataPersistence.shared.retrieveListOfCitiesViewed(), cities)
    }
}
