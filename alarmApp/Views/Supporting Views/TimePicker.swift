import SwiftUI

// TimePicker is a custom SwiftUI view for selecting a time using a DatePicker.
struct TimePicker: View {
    @Binding var time: Date // A binding to a Date property for selected time
    let scale: CGFloat // A scaling factor for the view's size

    var body: some View {
        // Display a DatePicker for selecting a time (hour and minute)
        DatePicker("", selection: $time, displayedComponents: .hourAndMinute).datePickerStyle(.automatic)
            .scaleEffect(scale) // Scale the size of the DatePicker
            .labelsHidden() // Hide the labels associated with the DatePicker
    }
}

// Preview for TimePicker
struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the TimePicker with initial time set to the current date and a specified scale
        TimePicker(time: .constant(Date()), scale: 1.3)
    }
}
