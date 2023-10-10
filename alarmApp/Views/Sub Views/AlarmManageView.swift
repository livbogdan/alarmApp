import SwiftUI

// AlarmManageView is a view for managing alarms.
// TODO: Add localized String for text elements.
struct AlarmManageView: View {
    var body: some View {
        ZStack {
            MainGradient(endRadius: 120, scaleX: 1.5) // Create a gradient background
                .cornerRadius(20) // Round the corners of the background
                .frame(height: screenHeight / 4) // Set the frame height
                .overlay(HStack {
                    CustomFont(text: "Add Alarm", size: 18) // Display "Add Alarm" text with custom font
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center) // Center-align the text
                        .frame(width: screenWidth / 1.8) // Set the text frame width
                }
                )
                .padding() // Apply padding to the ZStack
        }
    }
}

// Preview for AlarmManageView
struct AlarmManageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AlarmManageView() // Preview the AlarmManageView
        }
    }
}
