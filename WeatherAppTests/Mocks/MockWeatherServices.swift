//

import Foundation
@testable import WeatherApp

final class MockWeatherServices {
    
    private var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchWeatherData(_ completion: @escaping (Result<MockWeather, WeatherServicesError>) -> ()) throws {
        let request = try MockServiceCall(root: "https://api.worldweatheronline.com/premium/v1/weather.ashx", path: "test", method: "GET").urlRequest()
        self.apiClient.request(request) { (result: Result<MockWeather, WeatherServicesError> ) in
            completion(result)
        }
    }
    
    func fetchWeatherByCityName(cityName: String, completion: @escaping (Result<MockWeather, WeatherServicesError>) -> ()) throws {
        let request = try MockServiceCall(root: "https://api.worldweatheronline.com/premium/v1/weather.ashx", path: cityName, method: "GET").urlRequest()
        self.apiClient.request(request) { (result: Result<MockWeather, WeatherServicesError> ) in
            completion(result)
        }
    }
}

