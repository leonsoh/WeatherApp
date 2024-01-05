//

import Foundation
@testable import WeatherApp

final class MockWeatherServices {
    
    private var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchWeatherByCityName(cityName: String, completion: @escaping (Result<MockWeather, WeatherServicesError>) -> ()) throws {
        let request = try MockServiceCall(root: Constants.baseURL, path: cityName, method: "GET").urlRequest()
        self.apiClient.request(request) { (result: Result<MockWeather, WeatherServicesError> ) in
            completion(result)
        }
    }
}

