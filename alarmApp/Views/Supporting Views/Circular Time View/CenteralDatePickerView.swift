import SwiftUI

struct CenteralDatePickerView: View {
    let size: CGFloat
    @Binding var alarmModel: AlarmModel
    
    var lineWidth: CGFloat = 10.0
    
    // Extract the start and end times from the alarm model.
    var startTime: Date {
        alarmModel.start
    }
    
    var endTime: Date {
        alarmModel.end
    }
    
    // Calculate the percentage difference between start and end times.
    var percentDifference: CGFloat{
        let value = dateToPercent(date: endTime) - dateToPercent(date: startTime)
        
        // Handle cases where the value could be negative.
        return value >= 0 ? value : 1 + value
    }
    
    // Convert the start time to a percentage for rendering on the circle.
    var startDateToPercent: CGFloat {
        dateToPercent(date: startTime)
    }

    // Calculate the end date's percentage relative to the start date's percentage.
    var endDateToPercent: CGFloat {
        startDateToPercent + percentDifference
    }
    
    // Calculate the rotation offset for the circle based on the start date.
    var rotateCircleOffset: CGFloat {
        360 * startDateToPercent
    }
    
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
