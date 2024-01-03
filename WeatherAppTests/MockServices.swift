//

import XCTest
@testable import WeatherApp

final class MockServices: XCTestCase {
    var result: Result<WeatherResponse, WeatherServicesError>!
    var response: WeatherResponse!
    
    override func setUp() {
        let data = readMockJSONFile()
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                response = weatherData
                
            } catch let error {
                print(error)
            }
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
