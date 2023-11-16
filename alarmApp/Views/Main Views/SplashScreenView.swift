import SwiftUI

struct SplashScreenView: View {
    // State variable to control the view's activation
    @State private var isActive = false
    // Initial opacity value
    @State private var opacity = 0.3
    // Initial font size value
    @State private var fontSize = 15
    @State var isSignedIn = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        // Check if the view is active
        if isActive {
            // Show the MainAlarmView when isActive is true/
            
            if authViewModel.userSession != nil {
                MainAlarmView()
            } else {
                LogInScreenView()
            }
            
        } else {
            ZStack {
                // Create a view with four gradient circles
                FourGradientCircles(
                    color1: .blue,
                    color2: .red
                )
                
                VStack {
                    VStack (alignment: .leading, spacing: 0) {
                        // Display "Alarm App" with custom font
                        CustomFont(text: "Alarm App", size: CGFloat(fontSize))
                        // Display "By Bogdan" with custom font
                        CustomFont(text: "By Bogdan", size: CGFloat(fontSize))
                    }
                    // Align the text to the leading edge
                    .multilineTextAlignment(.leading)
                    // Add padding around the text
                    .padding()
                    .onAppear {
                        // Apply a fade-in animation
                        withAnimation(.easeIn(duration: 1.5)) {
                            // Increase opacity to 1 for fading in
                            opacity = 1.0
                            // Increase font size to 36 during the animation
                            fontSize = 36
                        }
                    }
                    
                    // Add a flexible spacer
                    Spacer()
                    
                    // Display an image with the name "welcome"
                    Image(welcome)
                        // Make the image resizable
                        .resizable()
                        // Scale the image to fit its frame
                        .scaledToFit()
                        // Set the image opacity
                        .opacity(0.7)
                    
                    // Add another flexible spacer
                    Spacer()
                }
            }
            // Set the overall opacity of the ZStack
            .opacity(opacity)
            .onAppear {
                // Schedule a task after 10 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    withAnimation {
                        // Activate the view with a fade-in animation after 10 seconds
                        isActive = true
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    // Activate the view with a tap gesture and a fade-in animation
                    isActive = true
                }
            }
        }
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
