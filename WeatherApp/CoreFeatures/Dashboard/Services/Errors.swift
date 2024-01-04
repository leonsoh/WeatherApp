//

import Foundation

public struct WeatherStatus: Decodable {
    let status: WeatherError
}

public struct WeatherError: Decodable {
    let error: [Error]
    
    struct Error: Codable {
        let msg: String
    }
}

public enum WeatherServicesError: Error {
    case serverError(WeatherError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

