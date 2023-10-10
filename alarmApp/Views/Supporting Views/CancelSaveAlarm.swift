import SwiftUI

// CancelSaveAlarm is a view for displaying "Cancel" and "Save" buttons for alarm management.
struct CancelSaveAlarm: View {
    let currenAlarmIndex: Int? // Optional index of the current alarm
    @Binding var alarmModel: AlarmModel // Binding to manage alarm settings
    
    var body: some View {
        HStack {
            Button(action: {print("cancel button")}, label: {Text("Cancel")}) // Display a "Cancel" button
            Spacer() // Add a flexible spacer to push the "Save" button to the right
            Button(action: {
                print("Save button")
                if let currenAlarmIndex = currenAlarmIndex {
                    // Add alarm to view model (handle the case when an index is provided)
                    print("\(currenAlarmIndex)")
                } else {
                    // Add alarm to view model (handle the case when no index is provided)
                }
            }, label: {Text("Save")}) // Display a "Save" button
        }
    }
}

// Preview for CancelSaveAlarm
struct CancelSaveView_Previews: PreviewProvider {
    static var previews: some View {
        CancelSaveAlarm(currenAlarmIndex: nil, alarmModel: .constant(.DefaultAlarm())) // Preview with default alarm settings
    }
}
