//

import Foundation

enum Endpoints {
    
    case fetchWeather(url: String = Constants.baseURL)
    
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        return components.url
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchWeather:
            return nil
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchWeather:
            return HTTPS.Method.get.rawValue
        }
    }
}


extension URLRequest {
    mutating func addValues(for endpoints: Endpoints) {
        switch endpoints {
        case .fetchWeather:
            self.setValue(HTTPS.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTPS.Headers.Key.format.rawValue)
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTPS.Headers.Key.apiKey.rawValue)
        }
    }
}
