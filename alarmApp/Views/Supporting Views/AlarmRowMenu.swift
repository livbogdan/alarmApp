import SwiftUI

struct AlarmRowMenu: View {
    let model: AlarmModel // Represents an AlarmModel object
    let i: Int // An index in the array

    var body: some View {
        HStack {
            // Display an image based on the activity from the AlarmModel
            Image(systemName: model.activity)
                .foregroundColor(model.activityColor) // Set the image color
                .font(.title) // Set the font size to .title

            // Display the time from the AlarmModel
            Text("\(getTimeFromDate(date: model.end))")
                .font(.title) // Set the font size to .title
                .fontWeight(model.alarmEnabled ? .regular : .thin) // Set font weight based on alarmEnabled
                .scaleEffect(model.alarmEnabled ? 1.05 : 1.1) // Adjust scale based on alarmEnabled
                .opacity(model.alarmEnabled ? 1.0 : 0.7) // Adjust opacity based on alarmEnabled

            Spacer() // Add a flexible space to push the toggle view to the right

            // Create a toggle view with a binding to the 'alarmEnabled' property of an AlarmModel
            let alarmViewModel = AlarmModel.DummyAlarmDate()
            TheToggleView(isOn: .constant(alarmViewModel[i].alarmEnabled))
        }
        .padding()
    }
}

struct AlarmRowMenu_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the AlarmRowMenu with a default AlarmModel and index 0
        AlarmRowMenu(model: .DefaultAlarm(), i: 0)
    }
}
