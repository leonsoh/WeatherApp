//

import Foundation

class Utilities {
    static let shared = Utilities()
    
    public func isRunningTests() -> Bool {
        let isRunningTests = NSClassFromString("XCTestCase") != nil
        return isRunningTests
    }
    
    public func formatStringFromArray(array: [String]) -> String {
        for string in array {
            let formattedString = string.replacingOccurrences(of: " ", with: "+")
            
            return formattedString
        }
        return ""
    }
       
}
