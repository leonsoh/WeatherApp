//

import Foundation

class WeatherServices : WeatherServicesProtocol {
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
        
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                
                do {
                    let weatherError = try JSONDecoder().decode(WeatherError.self, from: data ?? Data())
                    completion(.failure(.serverError(weatherError)))
                    
                } catch let error {
                    completion(.failure(.unknown()))
                    print(error.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                    
                    completion(.success(weatherData))
                    
                    
                } catch let error {
                    completion(.failure(.decodingError()))
                    print(error)
                }
                
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
}


protocol WeatherServicesProtocol {
    func fetchWeatherByCityName(cityName: String, completion: @escaping (Result<WeatherResponse, WeatherServicesError>)->Void)
}
