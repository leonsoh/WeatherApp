//

import XCTest
@testable import WeatherApp

final class DashboardServicesTests: XCTestCase {
    let mockService = MockServices()
    let mockWeatherService = MockWeatherServices(apiClient: MockServices())
    
    func testMockServiceSuccess() {
        guard let mockData = mockService.readMockJSONFile() else { return }
        
        MockURLProtocol.error = nil
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx/test")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, mockData)
        }
        
        let successExpectation = expectation(description: "Should succeed")
        
        try! mockWeatherService.fetchWeatherData { response in
            switch response {
            case .success(_):
                successExpectation.fulfill()
            case .failure(let error):
                print("Failure: \(error)")
            }
        }
        wait(for: [successExpectation], timeout: 2.0)
    }
    
    
    func testMockServiceFailure() {
        guard let mockData = mockService.readMockJSONFile() else { return }
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx")!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, mockData)
        }
        
        let failureExpectation = expectation(description: "Should fail")
        
        try! mockWeatherService.fetchWeatherData { response in
            switch response {
            case .failure(let error):
                failureExpectation.fulfill()
                
            default:
                break
            }
        }
        wait(for: [failureExpectation], timeout: 2.0)
    }
    
    func testFetchWeatherByCityNameSuccess() {
        guard let mockData = mockService.readMockJSONFile() else { return }
        
        MockURLProtocol.error = nil
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx/")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, mockData)
        }
        
        try! mockWeatherService.fetchWeatherByCityName(cityName: "Singapore") { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.data.request[0].name, "Singapore, Singapore")
            case .failure(let error):
                XCTFail("Failure was not expected: \(error)")
            }
        }
    }
}
