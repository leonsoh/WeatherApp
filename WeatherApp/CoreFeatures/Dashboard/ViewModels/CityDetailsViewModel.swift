//

import UIKit

class CityDetailsViewModel {
    
    let weather: WeatherResponse
    let currentCondition: CurrentCondition
    
    var listOfCitiesViewed: [String] = []
    
    init(_ weather: WeatherResponse) {
        self.weather = weather
        self.currentCondition = weather.data.currentCondition[0]
        self.listOfCitiesViewed = UserDefaults.standard.stringArray(forKey: DataPersistence.CITY_VIEWED_KEY) ?? [""]
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
        return "Temperature: \(self.currentCondition.tempC)°C"
    }
    
    var humidity: String {
        return "Humidity: \(self.currentCondition.humidity)"
    }
    
    func cityIsViewedByUser() {
        
        let cityCountryName = cityName.components(separatedBy: ",")
        guard let cityName = cityCountryName.first else { return }
        
        if !self.listOfCitiesViewed.contains(cityName) {
            self.listOfCitiesViewed = self.listOfCitiesViewed.filter({ $0 != ""})
            self.listOfCitiesViewed.append(cityName)
            
            UserDefaults.standard.set(listOfCitiesViewed, forKey: DataPersistence.CITY_VIEWED_KEY)
        }
    }
}

