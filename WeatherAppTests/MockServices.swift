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
            guard let fileUrl = Bundle.main.url(forResource: "MockJSON", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

}
