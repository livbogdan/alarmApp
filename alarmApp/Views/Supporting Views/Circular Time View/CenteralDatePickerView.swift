import SwiftUI

struct CenteralDatePickerView: View {
    let size: CGFloat
    @Binding var alarmModel: AlarmModel
    
    var lineWidth: CGFloat = 10.0
        
    var body: some View {
        Circle()
            .stroke(nickel, lineWidth: lineWidth)
            .frame(width: size, height: size)
            .overlay(
                VStack{
                    VStack{
                        // Display "Start" text with a caption font.
                        GrayTextView(text: "Start", font: .caption)
                        // Use a TimePicker for selecting the start time.
                        TimePicker(time: $alarmModel.start .animation(), scale: 1)
                    }
                    Spacer()
                    // Display "Set Alarm" in the middle of the circle.
                    GrayTextView(text: "Set Alarm")
                    Spacer()
                    VStack{
                        // Use a TimePicker for selecting the end time.
                        TimePicker(time: $alarmModel.end .animation(), scale: 1)
                        // Display "End" text with a caption font.
                        GrayTextView(text: "End", font: .caption)
                    }
                }
                .padding()
                .padding(.vertical)
            )
    }
}

struct CenteralDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the CenteralDatePickerView with sample data.
        CenteralDatePickerView(size: 200, alarmModel: .constant(AlarmModel.DefaultAlarm()))
    }
}
