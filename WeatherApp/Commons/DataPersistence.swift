//

import Foundation

struct DataPersistence {
    static let shared = DataPersistence()
    let defaults = UserDefaults.standard
    
    let cityViewedKey = "CityViewed"
    
    func saveStringArray(array: [String]) {
        defaults.set(array, forKey: cityViewedKey)
    }
    
    func retrieveListOfCitiesViewed() -> [String] {
        return defaults.stringArray(forKey: cityViewedKey) ?? [""]
    }
}


