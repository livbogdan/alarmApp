import SwiftUI

struct AddEditCircularAlarmView: View {
    let currentAlarmIndex: Int?
    @State var alarmModel: AlarmModel
    
    var body: some View {
        VStack {
            // Display the "Cancel" and "Save" buttons for managing alarms.
            CancelSaveAlarm(currenAlarmIndex: currentAlarmIndex, alarmModel: $alarmModel)
            
            // Toggle for enabling or disabling the alarm.
            AlarmToggleView(alarmEnable: $alarmModel.alarmEnabled)
            
            Divider() // Insert a divider line.
            Spacer() // Create a vertical spacer.
            
            // Display the CircularTimeView for setting alarm time.
            CircularTimeView(currentAlarmIndex: currentAlarmIndex, alarmModel: alarmModel, size: screenWidth / 2)
            
            Spacer() // Create another vertical spacer.
        }
    }
}

struct AddEditCircularView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the AddEditCircularAlarmView with sample data.
        AddEditCircularAlarmView(currentAlarmIndex: nil, alarmModel: .DefaultAlarm())
    }
}
