//

import Foundation

class Utilities {
    static let shared = Utilities()
    
    public func isRunningTests() -> Bool {
        let isRunningTests = NSClassFromString("XCTestCase") != nil
        return isRunningTests
    }
    
    public func formatString(string: String) -> String {
        let formattedString = string.replacingOccurrences(of: " ", with: "+")
        
        return formattedString
    }
       
}
