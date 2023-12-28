//

import Foundation

struct Weather: Codable {
    let temperature: Int
    let humidity: Int
    let description: String
    let iconUrl: String?
    

    enum CodingKeys: String, CodingKey {
        case temperature = "tempC"
        case humidity = "humidity"
        case description = "weatherDesc"
        case iconUrl = "weatherIconUrl"
        
    }
}

struct WeatherArray: Decodable {
    let data: [Weather]
}
