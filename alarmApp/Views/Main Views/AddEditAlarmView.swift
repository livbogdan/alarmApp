import SwiftUI

// AddEditAlarmView is a view for adding or editing an alarm.
struct AddEditAlarmView: View {
    let currentAlramIndex: Int? // Optional index of the current alarm
    @State var alarmModel: AlarmModel // State variable to store alarm settings
    @State private var showAlarmManageView = true // State variable to control showing the AlarmManageView
    
    var body: some View {
        ZStack {
            backgroundColor
                .opacity(0.7)
                .ignoresSafeArea() // Semi-transparent background covering the screen
            
            VStack {
                if showAlarmManageView {
                    AlarmManageView() // Display the AlarmManageView when showAlarmManageView is true
                }
                
                AddSaveMangeView(currentAlramIndex: currentAlramIndex, alarmModel: alarmModel)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                withAnimation {
                    showAlarmManageView = false // Hide the AlarmManageView after 10 seconds
                }
            }
        }
    }
}

// Preview for AddEditAlarmView
struct AddEditAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditAlarmView(currentAlramIndex: nil, alarmModel: .DefaultAlarm()) // Preview with default alarm settings
    }
}
