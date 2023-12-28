//

import Foundation


enum WeatherServicesError {
    case serverError(WeatherError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}
