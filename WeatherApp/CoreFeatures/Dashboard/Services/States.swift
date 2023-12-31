//

import Foundation

struct WeatherStatus: Decodable {
    let status: WeatherError
}

struct WeatherError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}

enum WeatherServicesError: Error {
    case serverError(WeatherError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}
