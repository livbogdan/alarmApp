import SwiftUI

// CancelSaveAlarm is a view for displaying "Cancel" and "Save" buttons for alarm management.
struct CancelSaveAlarm: View {
    let currenAlarmIndex: Int? // Optional index of the current alarm
    @Binding var alarmModel: AlarmModel // Binding to manage alarm settings
    
    @EnvironmentObject var lnManager: LocalNotificationManager
    @Environment(\.presentationMode) var presintation
    
    var body: some View {
        HStack {
            Button(action: {
                print("cancel button")
                stopPlaying()
                self.presintation
                    .wrappedValue
                    .dismiss()
            }, label: {
                Text("Cancel")
                
            }) // Display a "Cancel" button
            Spacer() // Add a flexible spacer to push the "Save" button to the right
            Button(action: {
                print("Save button")
                if let currenAlarmIndex = currenAlarmIndex {
                    // Add alarm to view model (handle the case when an index is provided)
                    lnManager.alarmViewModels[currenAlarmIndex] = alarmModel
                } else {
                    // Add alarm to view model (handle the case when no index is provided)
                    lnManager
                        .safeAppend(localNotification: alarmModel)
                }
                
                Task {
                    if alarmModel.alarmEnabled{
                        await lnManager.schedule(localNotification: alarmModel)
                    } else {
                        lnManager.removeRequest(id: alarmModel.id)
                    }
                }
                
                self.presintation
                    .wrappedValue
                    .dismiss()
            }, label: {Text("Save")}) // Display a "Save" button
        }
        .padding()
    }
}

// Preview for CancelSaveAlarm
struct CancelSaveView_Previews: PreviewProvider {
    static var previews: some View {
        CancelSaveAlarm(currenAlarmIndex: nil, alarmModel: .constant(.DefaultAlarm()))
            .environmentObject(LocalNotificationManager())// Preview with default alarm settings
    }
}
