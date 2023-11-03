import SwiftUI

struct CircularTimeView: View {
    let currentAlarmIndex: Int?
    @Binding var alarmModel: AlarmModel
    
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
    
    let size: CGFloat
    
    var body: some View {
        // Create a circular shape with a stroke of 20 units.
        ZStack {
            CenteralDatePickerView(size: size, alarmModel: $alarmModel)
            
            TimeArcView(percentDifference: percentDifference,
                        strokeStyle: StrokeStyle(lineWidth: 20,
                                                 lineCap: .round,
                                                 lineJoin: .round),
                        size: size,
                        rotateCircleOffset: rotateCircleOffset,
                        color: black)
            
            TimeArcView(percentDifference: percentDifference,
                        strokeStyle: StrokeStyle(lineWidth: 15, dash: [1,2]),
                        size: size,
                        rotateCircleOffset: rotateCircleOffset,
                        color: .white)
            
           CircularTimeIcon(time: startTime, size: size, percent: startDateToPercent)
            
           CircularTimeIcon(time: endTime, size: size, percent: endDateToPercent)
            
            
        }
    }
}

struct CircularTimeView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the CircularTimeView with sample data.
        CircularTimeView(currentAlarmIndex: nil, alarmModel: .constant(.DefaultAlarm()), size: screenWidth / 2)
    }
}
