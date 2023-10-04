import Foundation

// Define a struct to represent a time model with hours and minutes
struct TimeModel: Equatable, Comparable, Identifiable {
    // Custom comparison function for TimeModel
    static func < (lhs: TimeModel, rhs: TimeModel) -> Bool {
        // Compare hours first, and if they are equal, compare minutes
        if lhs.hours < rhs.hours {
            return true
        } else if lhs.hours == rhs.hours && lhs.minutes < rhs.minutes {
            return true
        } else {
            return false
        }
    }
    
    let id = UUID() // Generate a unique identifier for each TimeModel
    let hours: Int // Hours component of the time
    let minutes: Int // Minutes component of the time
}
