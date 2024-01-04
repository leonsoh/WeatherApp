//

import Foundation

class WeatherServices {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchWeatherByCityName(cityName: String, completion: @escaping (Result<WeatherResponse, WeatherServicesError>)->Void) {
        
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.path = Constants.baseURL
        components.queryItems = [
            URLQueryItem(name: Params.key.rawValue, value: Constants.API_KEY),
            URLQueryItem(name: Params.query.rawValue, value: cityName),
            URLQueryItem(name: Params.format.rawValue, value: Constants.jsonFormat),
        ]
        
        guard let url = components.url else { return }
        
        
        let dataTask = urlSession.dataTask(with: url) { data, resp, error in
            do {
                if let error = error {
                    completion(.failure(.unknown(error.localizedDescription)))
                    throw error
                }
                
                guard let httpRes = resp as? HTTPURLResponse, 200..<300 ~= httpRes.statusCode else {
                    completion(.failure(.unknown("Network Error")))
                    return
                }
                
                if let data = data, let obj = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                    print(obj)
                    completion(.success(obj))
                } else {
                    completion(.failure(.decodingError("Decoding Error")))
                    throw WeatherServicesError.decodingError("Decoding Error")
                }
            } catch {
                completion(.failure(.unknown("Error occured")))
            }
        }
        dataTask.resume()
    }
}
