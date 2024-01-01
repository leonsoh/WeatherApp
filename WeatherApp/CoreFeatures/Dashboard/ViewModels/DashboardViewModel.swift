//

import Foundation
import UIKit

class DashboardViewModel {
    var onDashboardUpdated: (() -> Void)?
    var onErrorMessage: ((WeatherServicesError) -> Void)?
    
    var cities = CityList.cities
    
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
    
    // MARK: - Initializer
    init() {
        self.fetchWeatherData()
        self.fetchWeatherDataViewedByUser()
    }
    
    func fetchWeatherData() {
        for city in cities {
            WeatherServices.fetchWeatherByCityName(cityName: city) { [weak self] result in
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
        var cityNames = DataPersistence.shared.retrieveListOfCitiesViewed()
        
        self.citiesViewedByUser = []
        
        for name in cityNames {
            let formattedCityName = name.replacingOccurrences(of: " ", with: "+")
            
            if formattedCityName != "" {
                WeatherServices.fetchWeatherByCityName(cityName: formattedCityName) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.citiesViewedByUser.append(data)
                        
                    case .failure(let error):
                        self?.onErrorMessage?(error)
                    }
                    
                }
            }
            
        }
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
