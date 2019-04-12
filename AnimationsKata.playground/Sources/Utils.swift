import Foundation


public extension Date {
    static func currentMillis() -> Double {
        return Double(Date().timeIntervalSince1970 * 1000)
    }
}
