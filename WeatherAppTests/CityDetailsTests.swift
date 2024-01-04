//

import XCTest
@testable import WeatherApp

class CityDetailsTests: XCTestCase {
    
    var sut: CityDetailsViewModel!
    
    override func setUp() {
        let mockService = MockServices()
        let data = mockService.readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                sut = CityDetailsViewModel(weatherData)
                
            } catch let error {
                print(error)
            }
        }
    }
    
    override func tearDown() {
        sut = nil
        removeStoredCities()
    }
    
    
    func testWeatherDescriptionIsString() {
        let weatherDesc = sut.weatherDescription
        XCTAssertEqual(weatherDesc, "Light Rain")
    }
    
    func testWeatherTemperatureIsString() {
        let temperature = sut.temperature
        XCTAssertEqual(temperature, "Temperature: 26°C")
    }
    
    func testWeatherHumidityIsString() {
        let humidity = sut.humidity
        XCTAssertEqual(humidity, "Humidity: 94")
    }
    
    func testWeatherIconUrlIsString() {
        let weatherIconUrl = sut.weatherIcon
        XCTAssertEqual(weatherIconUrl, "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0033_cloudy_with_light_rain_night.png")
        
    }
    
    func testIfCityNameExists() {
        let cityName = sut.cityName
        XCTAssertTrue(!cityName.isEmpty)
    }
    
    func testIfCityViewedByUser() {
        sut.cityIsViewedByUser()
        let listOfCitiesViewed = UserDefaults.standard.stringArray(forKey: DataPersistence.CITY_VIEWED_KEY) ?? [""]
       
        XCTAssertEqual(listOfCitiesViewed, ["Singapore"])
    }
}

extension CityDetailsTests {
    func removeStoredCities() {
        UserDefaults.standard.removeObject(forKey: DataPersistence.CITY_VIEWED_KEY)
        UserDefaults.standard.synchronize()
    }
}
