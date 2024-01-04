//

import Foundation

public protocol APIClientProtocol {
    var urlSession: URLSession { get }
    func request<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, WeatherServicesError>) -> Void)
}

extension APIClientProtocol {
    
    public var urlSession: URLSession {
        return URLSession.shared
    }
    
    public func request<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, WeatherServicesError>) -> Void) {
        let task = urlSession.dataTask(with: request) { data, response, error in
            var result: Result<T, WeatherServicesError>
            if let error = error {
                result = .failure(.unknown(error.localizedDescription))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.unknown("Request Failed!")))
            }
            
            guard (200 ... 299).contains(httpResponse.statusCode) else {
                return completion(.failure(.unknown("Request Failed!")))
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                    result = .success(decoded)
                } catch {
                    result = .failure(.decodingError("Decoding Error"))
                }
            } else {
                result = .failure(.unknown("No Data Error!"))
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        task.resume()
    }
}
