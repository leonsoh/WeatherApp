//

import Foundation

class Utilities {
    static let shared = Utilities()
    
    public func isRunningTests() -> Bool {
        let isRunningTests = NSClassFromString("XCTestCase") != nil
        return isRunningTests
    }
}
