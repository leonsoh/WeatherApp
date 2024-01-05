//

import Foundation
import UIKit

class DashboardViewModel: DashboardDelegate {
    
    var onDashboardUpdated: (() -> Void)?
    var onErrorMessage: ((WeatherServicesError) -> Void)?
    
    var cities = CityList.cities
    let weatherServices = WeatherServices()
    
    private(set) var cityData: [WeatherResponse] = [] {
        didSet {
            self.onDashboardUpdated?()
        }
    }
    
    private(set) var citiesViewedByUser: [WeatherResponse] = [] {
        didSet {
            self.onDashboardUpdated?()
        }
    }
    
    private(set) var filteredCities: [WeatherResponse] = []
    
    
    func fetchWeatherData() {
        for city in cities {
            weatherServices.fetchWeatherByCityName(cityName: city) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.cityData.append(data)
                    
                case .failure(let error):
                    self?.onErrorMessage?(error)
                }
            }
        }
    }
    
    func fetchWeatherDataViewedByUser() {
        let cityNames = UserDefaults.standard.stringArray(forKey: DataPersistence.CITY_VIEWED_KEY) ?? [""]
        
        self.citiesViewedByUser = []
        
        let cityName = Utilities.shared.formatStringFromArray(array: cityNames)
        
        if cityName != "" {
            weatherServices.fetchWeatherByCityName(cityName: cityName) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.citiesViewedByUser.append(data)
                case .failure(let error):
                    self?.onErrorMessage?(error)
                }
            }
        }
    }
    
    
    func displayTenRecentCities() -> Int {
        let recentMaxCount = 10
        
        if self.citiesViewedByUser.count > recentMaxCount {
            return recentMaxCount
        } else {
            return self.citiesViewedByUser.count
        }
    }
    
    func getCityData(data: WeatherResponse) -> [WeatherResponse] {
        self.cityData.append(data)
        return self.cityData
    }
    
    func getCitiesViewedByUser(data: WeatherResponse) -> [WeatherResponse] {
        self.citiesViewedByUser.append(data)
        return self.citiesViewedByUser
    }
}

extension DashboardViewModel {
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
                
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCities = cityData
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onDashboardUpdated?(); return }
            
            self.filteredCities = self.filteredCities.filter({ $0.data.request[0].name.lowercased().contains(searchText)})
        }
        
        self.onDashboardUpdated?()
    }
}


protocol DashboardDelegate {
    func getCityData(data: WeatherResponse) -> [WeatherResponse]
    func getCitiesViewedByUser(data: WeatherResponse) -> [WeatherResponse]
}
