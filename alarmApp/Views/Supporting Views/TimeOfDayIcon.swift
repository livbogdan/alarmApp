import SwiftUI

// A SwiftUI view for displaying icons representing different times of day based on the given date.
struct TimeOfDayIcon: View {
    let date: Date
    var precent: CGFloat{
        dateToPercent(date: date)
    }
    var hour: Int {
        Int(24*precent)
    }
    
    // Determine the image and color based on the hour of the day.
    var image: (name: String, color: Color){
        switch(hour) {
        case 6..<8:
            return ("sunrise.fill", coral)
        case 8..<17:
            return ("sun.max.fill", yellow)
        case 17..<20:
            return ("sun.and.horizon.fill", orange)
        case 20..<23:
            return ("moon.fill", gray)
        default:
            return ("moon.stars.fill", black)
            
        }
    }
    
    // The body of the view, which displays an image with the determined name and color.
    var body: some View {
        Image(systemName: image.name)
            .foregroundColor(image.color)
            .imageScale(.large)
    }
}

struct TimeOfDayIcon_Previews: PreviewProvider {
    static var previews: some View {
        // Display a list of TimeOfDayIcon views for each hour of the day.
        List(0..<24) { item in
            HStack {
                // Calculate the Date for the current hour.
                let theDate = addHourToDate(date: Date(), numHours: item, numMinutes: 0)
                
                // Display the time and the TimeOfDayIcon for the current hour.
                Text(getTimeFromDate(date: theDate))
                Spacer()
                TimeOfDayIcon(date: theDate)
            }
            .padding()
        }
    }
}
