import SwiftUI

// EnableNotifications is a view for enabling notifications.
// TODO: Implement logic for enabling notifications.
struct EnableNotifications: View {
    var body: some View {
        ZStack {
            FourGradientCircles() // Display four gradient circles in the background
            VStack {
                
                Spacer() // Create a space at the top
                
                CustomFont(text: "Enable notifications", size: 50) // Display "Enable notifications" text with a custom font
                    .multilineTextAlignment(.center) // Center-align the text
                
                Spacer() // Create a space in the middle
                
                // TODO: Implement logic for enabling notifications
                Button(action: {print("enable")}, label: {ButtonView(text: "Enable") // Display an "Enable" button
                        .padding() // Apply padding to the button
                })
            }
        }
    }
}

// Preview for EnableNotifications
struct EnableNotifications_Previews: PreviewProvider {
    static var previews: some View {
        EnableNotifications() // Preview the EnableNotifications view
    }
}
