//

import UIKit

class CityDetailsViewModel {
    
    let weather: WeatherResponse
    let currentCondition: CurrentCondition
    
    var listOfCitiesViewed: [String] = []
    
    init(_ weather: WeatherResponse) {
        self.weather = weather
        self.currentCondition = weather.data.currentCondition[0]
        self.listOfCitiesViewed = DataPersistence.shared.retrieveListOfCitiesViewed()
    }
    var cityName: String {
        return "\(self.weather.data.request[0].name)"
    }
     
    var weatherDescription: String {
        return "\(self.currentCondition.weatherDesc[0].value)"
    }
    
    var weatherIcon: String {
        return "\(self.currentCondition.weatherIconURL[0].value)"
    }
    
    var temperature: String {
        return "Temperature in degree: \(self.currentCondition.tempC)"
    }
    
    var humidity: String {
        return "Humidity: \(self.currentCondition.humidity)"
    }
    
    func cityIsViewedByUser() {
        let cityCountryName = cityName.components(separatedBy: ",")
        guard let cityName = cityCountryName.first else { return }
        
        if !self.listOfCitiesViewed.contains(cityName) {
            self.listOfCitiesViewed.append(cityName)
            DataPersistence.shared.saveStringArray(array: listOfCitiesViewed)
        }
        
    }
}
