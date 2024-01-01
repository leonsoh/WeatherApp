//

import XCTest
@testable import WeatherApp

final class MockServices: XCTestCase {
    var result: Result<WeatherResponse, WeatherServicesError>!
    
    func fetchWeatherData(completion: @escaping(Result<WeatherResponse, WeatherServicesError>) -> Void) {
        completion(result)
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
