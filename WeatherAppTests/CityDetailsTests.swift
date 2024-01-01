//

import XCTest
@testable import WeatherApp

final class CityDetailsTests: XCTestCase {
    let mockService = MockServices()
    
    func testWeatherDescriptionIsString() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let weatherDesc = weatherData.data.currentCondition[0].weatherDesc[0].value
                XCTAssertEqual(weatherDesc, "Light Rain")
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testWeatherTemperatureIsString() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let temp = weatherData.data.currentCondition[0].tempC
                XCTAssertEqual(temp, "26")
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testWeatherHumidityIsString() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let humidity = weatherData.data.currentCondition[0].humidity
                XCTAssertEqual(humidity, "94")
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testWeatherIconUrlIsString() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let weatherIconUrl = weatherData.data.currentCondition[0].weatherIconURL[0].value
                XCTAssertEqual(weatherIconUrl, "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0033_cloudy_with_light_rain_night.png")
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func testIfCityNameExists() {
        let data = mockService.readMockJSONFile()
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                let cityName = weatherData.data.request[0].name
                XCTAssertTrue(!cityName.isEmpty)
                
            } catch let error {
                print(error)
            }
        }
    }
}
