//

import Foundation

struct DataPersistence {
    static let shared = DataPersistence()
    let defaults = UserDefaults.standard
    
    func saveStringUserDefaults(string: String) {
        defaults.set(string, forKey: string)
    }
    
    func retrieveStringUserDefaults(key: String) -> String {
        return defaults.string(forKey: key) ?? ""
    }
    
//    func saveIntUserDefaults(int: Int) {
//        defaults.set(int, forKey: "CitiesViewed")
//    }
    
    func retrieveIntUserDefaults(key: String) -> Int {
        return defaults.integer(forKey: key)
    }
    
    func saveStringArray(array: [String]) {
        defaults.set(array, forKey: "CityViewed")
    }
    
    func retrieveListOfCitiesViewed() -> [String] {
        return defaults.stringArray(forKey: "CityViewed") ?? [""]
    }
}


