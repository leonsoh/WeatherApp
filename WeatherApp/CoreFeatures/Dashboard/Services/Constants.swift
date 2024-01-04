//

import Foundation

class Constants {
    //Insert your API Keys
    static let API_KEY = "05e05d4872424f7481084546240301"
    static let scheme = "https"
    static let baseURL = "api.worldweatheronline.com/premium/v1/weather.ashx"
    static let jsonFormat = "json"
    
}

enum Params: String {
    case key = "key"
    case query = "q"
    case format = "format"
}

enum HTTPS {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
}
