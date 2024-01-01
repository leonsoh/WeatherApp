//

import Foundation

struct DataPersistence {
    static let shared = DataPersistence()
    
    private let CITY_VIEWED_KEY = "CityViewed"
    private let defaults = UserDefaults.standard
    
    func saveListOfCitiesViewed(array: [String]) {
        defaults.set(array, forKey: CITY_VIEWED_KEY)
    }
    
    func retrieveListOfCitiesViewed() -> [String] {
        return defaults.stringArray(forKey: CITY_VIEWED_KEY) ?? [""]
    }
}


