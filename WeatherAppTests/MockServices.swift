//

import Foundation
@testable import WeatherApp

class MockServices: WeatherServicesProtocol {
    func fetchWeatherByCityName(cityName: String, completion: @escaping (Result<WeatherApp.WeatherResponse, WeatherApp.WeatherServicesError>) -> Void) {
        if cityName.isEmpty {
            completion(.failure(WeatherServicesError.decodingError()))
        }
        
        let data = readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(weatherData))
                

            } catch let error {
                print(error)
                
            }
        } else {
            completion(.failure(WeatherServicesError.unknown()))
            
        }
    }
    
    
    func readMockJSONFile() -> Data? {
        do {
            let bundle = Bundle(for: type(of: self))
            if let bundlePath = bundle.path(forResource: "MockJSON", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
