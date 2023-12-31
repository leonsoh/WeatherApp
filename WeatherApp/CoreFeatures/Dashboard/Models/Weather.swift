//

import Foundation

struct WeatherResponse: Codable {
    let data: DataClass
    
    struct DataClass: Codable {
        let request: [City]
        let currentCondition: [CurrentCondition]
        
        enum CodingKeys: String, CodingKey {
            case request
            case currentCondition = "current_condition"
        }
    }
    
}


struct CurrentCondition: Codable {
    let tempC: String
    let weatherIconURL, weatherDesc: [Weather]
    let humidity: String
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_C"
        case weatherIconURL = "weatherIconUrl"
        case weatherDesc, humidity
      
    }
}

struct Weather: Codable {
    let value: String
}

struct City: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "query"
    }
}





