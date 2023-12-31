//

import Foundation

class CommonUtilies {
    static let shared = CommonUtilies()
    
    func loadJson(filename fileName: String) -> City? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(City.self, from: data)
                
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
