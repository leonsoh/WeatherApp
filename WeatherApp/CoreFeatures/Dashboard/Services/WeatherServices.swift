//

import Foundation

class WeatherService {
    
    static func fetchWeather(with endpoint: Endpoints, completion: @escaping (Result<[Weather], CoinServiceError>)->Void) {
            guard let request = endpoint.request else { return }
            
            
            URLSession.shared.dataTask(with: request) { data, resp, error in
                if let error = error {
//                    completion(.failure(.unknown(error.localizedDescription)))
                    return
                }
                
                if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                    
//                    do {
//                        let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
//                        completion(.failure(.serverError(coinError)))
//                        
//                    } catch let err {
//                        completion(.failure(.unknown()))
//                        print(err.localizedDescription)
//                    }
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let weatherData = try decoder.decode(WeatherArray.self, from: data)
                        completion(.success(weatherData.data))
                        
                    } catch let err {
                        completion(.failure(.decodingError()))
                        print(err.localizedDescription)
                    }
                    
                } else {
                    completion(.failure(.unknown()))
                }
                
            }.resume()
        }
}
