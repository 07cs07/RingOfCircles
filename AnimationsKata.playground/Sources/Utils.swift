import Foundation


public extension Date {
    static func currentTimeMillis() -> Double {
        return Double(Date().timeIntervalSince1970 * 1000)
    }
}
