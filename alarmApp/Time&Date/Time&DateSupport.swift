import Foundation

// Function to format a given Date into a string representation of time (HH:mm).
func getTimeFromDate(date: Date) -> String {
    // Extract the hour and minute components from the date.
    let result = getTimeComponents(date: date)
    let hour = result.hour
    let minute = result.minute
    
    // Format the time as "HH:mm".
    let time = String(format: "%02d:%02d", hour, minute)
    
    return time
}

// Function to add a specified number of hours and minutes to a given Date.
func addHourToDate(date: Date, numHours: Int, numMinutes: Int) -> Date {
    // Calculate the time interval to add to the date in seconds.
    let timeInterval = TimeInterval(numMinutes * 60 + numHours * 60 * 60)
    
    // Add the calculated time interval to the date.
    return date.addingTimeInterval(timeInterval)
}

// Function to extract various components (hour, minute, day, month, year) from a Date.
func getTimeComponents(date: Date) -> (hour: Int, minute: Int, day: Int, month: Int, year: Int) {
    // Use Calendar.current to extract the desired date components from the input date.
    let components = Calendar.current.dateComponents(
        [.hour,.month,.year, .day,.minute], from: date)
    
    // Extract individual components (default to 0 if not found).
    let hour = components.hour ?? 0
    let minute = components.minute ?? 0
    let day = components.day ?? 0
    let month = components.month ?? 0
    let year = components.year ?? 0
    
    // Return the extracted components as a tuple.
    return (hour: hour, minute: minute, day: day, month: month, year: year)
}

// Function to convert a Date into a percentage of the day (0.0 to 1.0).
func dateToPercent(date: Date) -> CGFloat {
    // Extract the hour and minute components from the date.
    let result = getTimeComponents(date: date)
    
    // Calculate the percentage of the day based on the hour and minute.
    return CGFloat(result.hour) / 24 + CGFloat(result.minute) / (60*24)
}

//Extraction  of the Date that enables to substract dates
extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

func formatDate(date: Date) -> String {
    let result = getTimeComponents(date: date)
    
    return
        "\(result.day) - \(result.minute) -\(result.year)(\(result.hour):\(result.minute)) "
}

func dateToTimeModel(date: Date) -> TimeModel {
    let result = getTimeComponents(date: date)
    
    return TimeModel(hours: result.hour, minutes: result.minute)
}
