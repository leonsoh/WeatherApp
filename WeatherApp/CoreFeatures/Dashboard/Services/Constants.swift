//

import Foundation

class Constants {
    //Insert your API Keys
    static let API_KEY = "ca5b52516b83403d8dc122230232712"
    static let baseURL = "https://api.worldweatheronline.com/premium/v1/weather.ashx?"
    static let scheme = "https"
}


enum HTTPS {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {
        enum Key: String {
            case apiKey = "key"
            case format = "format"
        }
        enum Value: String {
            case applicationJson = "json"
        }
    }
    
}
