//

import Foundation
@testable import WeatherApp

class MockServices: APIClientProtocol {
    var urlSession: URLSession {
        //Store session-related data in RAM instead of disk
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
    
    func readMockJSONFile(fileName: String? = "MockJSON") -> Data? {
        do {
            let bundle = Bundle(for: type(of: self))
            if let bundlePath = bundle.path(forResource: fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
