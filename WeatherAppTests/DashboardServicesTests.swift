//

import XCTest
@testable import WeatherApp

final class DashboardServicesTests: XCTestCase {
    let mockService = MockServices()
    var sut: WeatherServices!
    
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = WeatherServices(urlSession: urlSession)
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
        
        
        sut.fetchWeatherByCityName(cityName: "Singapore") { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.data.request[0].name, "Singapore, Singapore")
            case .failure(let error):
                XCTFail("Failure was not expected: \(error)")
            }
        }
    }
    
    func testFetchWeatherByCityNameFailure() {
        let mockData = mockService.readMockJSONFile(fileName: "StubFailureJSON")!

        MockURLProtocol.error = nil
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx/")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, mockData)
        }
        
        
        sut.fetchWeatherByCityName(cityName: "") { result in
            switch result {
            case .success(let weather):
                XCTFail("Success was not expected")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testServiceErrorWhenLoading() {
        guard let mockData = mockService.readMockJSONFile() else { return }

        MockURLProtocol.error = WeatherServicesError.unknown("Error") as Error
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx/")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, mockData)
        }
        
        
        sut.fetchWeatherByCityName(cityName: "") { result in
            switch result {
            case .success(let weather):
                XCTFail("Success was not expected")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testStatusCode400Error() {
        guard let mockData = mockService.readMockJSONFile() else { return }
        
        MockURLProtocol.error = nil
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx/")!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, mockData)
        }
        
        
        sut.fetchWeatherByCityName(cityName: "Singapore") { result in
            switch result {
            case .success(let weather):
                XCTFail("Success was not expected: \(weather.data.currentCondition)")
            case .failure(let error):
                print(error)
                XCTAssertNotNil(error)
            }
        }
    }
}
