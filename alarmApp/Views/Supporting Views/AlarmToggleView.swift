import SwiftUI

// AlarmToggleView is a custom view for displaying a toggle switch for enabling/disabling alarms.
struct AlarmToggleView: View {
    @Binding var alarmEnable: Bool // Binding to track the state of the alarm toggle switch
    
    var body: some View {
        HStack {
            GrayTextView(text: "Alarm") // Display the text "Alarm"
            Spacer() // Add a flexible spacer to push the toggle to the right
            TheToggleView(isOn: $alarmEnable) // Display the custom toggle switch with a binding to alarmEnable
        }
        .padding() // Apply padding to the HStack
    }
}

// Preview for AlarmToggleView
struct AlarmToggleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AlarmToggleView(alarmEnable: .constant(true)) // Preview for the alarm toggle switch in the "On" state
            AlarmToggleView(alarmEnable: .constant(false)) // Preview for the alarm toggle switch in the "Off" state
        }
    }
}
