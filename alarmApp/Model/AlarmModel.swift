import Foundation
import SwiftUI

// Define a struct to represent an alarm with various properties
struct AlarmModel: Identifiable, Codable {

    // MARK: - Properties
    
    let id = UUID().uuidString // Generate a unique identifier for each alarm
    
    let title: String // The title of the alarm
    let body: String // A description or additional information for the alarm
    let repeats: Bool // Indicates whether the alarm repeats
    var sound: Sounds // The sound associated with the alarm
    var alarmEnabled: Bool // Indicates whether the alarm is enabled
    
    var start: Date // The start time of the alarm
    var end: Date // The end time of the alarm
    
    // An associated activity or icon for the alarm
    var activity: String
    
    // Index representing the color associated with the alarm
    var colorIndex: Int
    
    // Compute the associated color using colorIndex
    var activityColor: Color {
        mainColors[colorIndex]
    }

    // MARK: - Computed Properties
    
    // Calculate the duration of the alarm
    var timeInterval: TimeInterval {
        end - start
    }
    
    // Convert the start time to a TimeModel
    var startTime: TimeModel {
        dateToTimeModel(date: start)
    }
    
    // Convert the end time to a TimeModel
    var endTime: TimeModel {
        dateToTimeModel(date: end)
    }
    
    var endDateComponents: DateComponents {
        Calendar.current.dateComponents([.hour,.minute], from: self.end)
    }

    // MARK: - Factory Methods
    
    // Factory method to create a default alarm
    static func DefaultAlarm() -> AlarmModel {
        AlarmModel(title: "Activity Completed",
                   body: "Have",
                   repeats: false,
                   sound: .beat_mixed_full,
                   alarmEnabled: false,
                   start: Date(),
                   end: Date(),
                   activity: activities[0],
                   colorIndex: 0)
    }
    
    // Factory method to create dummy alarm data for testing
//    static func DummyAlarmDate() -> [AlarmModel] {
//        
//        // Sample alarm instances
//        [
//            AlarmModel(title: "Titel1", body: "body1", repeats: false, sound: .beat_mixed_full, alarmEnabled: true, start: Date(), end: addHourToDate(date: Date(), numHours: 3, numMinutes:  10), activity: "moon.zzz.fill", colorIndex: 2),
//            AlarmModel(title: "Titel2", body: "body2", repeats: true, sound: .kick_and_snare_hip_hop, alarmEnabled: false, start: Date(), end: addHourToDate(date: Date(), numHours: 0, numMinutes:  5), activity: "moon.fill", colorIndex: 0),
//            AlarmModel(title: "Titel3", body: "body3", repeats: true, sound: .mixed_hip_hop_beat, alarmEnabled: true, start: Date(), end: addHourToDate(date: Date(), numHours: 5, numMinutes:  5), activity: "sunrise.fill", colorIndex: 3)
//        ]
//        
//        // Sort alarms by end time
//        .sorted(by: {$0.endTime < $1.endTime})
//    }
}
