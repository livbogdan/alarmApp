import SwiftUI

struct CircularTimeView: View {
    let currentAlarmIndex: Int?
    @State var alarmModel: AlarmModel
    
    let size: CGFloat
    
    var body: some View {
        // Create a circular shape with a stroke of 20 units.
        Circle()
            .stroke(lineWidth: 20)
            .frame(width: screenWidth/2) // Frame size is half of the screen width.
            .overlay(Text("Circular Alarm")) // Overlay text inside the circle.
    }
}

struct CircularTimeView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the CircularTimeView with sample data.
        CircularTimeView(currentAlarmIndex: nil, alarmModel: .DefaultAlarm(), size: screenWidth / 2)
    }
}
