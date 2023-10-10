import SwiftUI

// Represents a view with a colored circle
struct CircleView: View {
    let radius: CGFloat
    var color1 = yellow
    var color2 = blue
    
    var body: some View {
        Circle()
            .fill(LinearGradient(colors: [color1, color2],
                                 startPoint: .top,
                                 endPoint: .bottom)) // Gradient-filled circle
            .frame(width: radius,
                   height: radius) // Set the frame size
    }
}

// Represents a view with four gradient-filled circles
struct FourGradientCircles: View {
    var color1 = yellow
    var color2 = blue
    @State private var offsetX: [CGFloat] = [0, 0, 0, 0] // Array to store X offsets
    @State private var offsetY: [CGFloat] = [0, 0, 0, 0] // Array to store Y offsets
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // Timer for animations
    
    var body: some View {
        ZStack {
            // First circle with an offset
            CircleView(radius: screenWidth / 5, color1: color1, color2: color2.opacity(0.3))
                .offset(x: screenWidth / 4, y: screenHeight / 4)
                .offset(x: offsetX[0], y: offsetY[0])
            
            // Second circle with an offset
            CircleView(radius: screenWidth / 10, color1: color1, color2: color2.opacity(0.3))
                .offset(x: -screenWidth / 3, y: screenHeight / 4)
                .offset(x: offsetX[1], y: offsetY[1])
            
            // Third circle with an offset
            CircleView(radius: screenWidth / 9, color1: color1, color2: color2.opacity(0.3))
                .offset(x: (1 / 3) * screenWidth, y: screenHeight / 20)
                .offset(x: offsetX[2], y: offsetY[2])

            // Fourth circle with an offset
            CircleView(radius: screenWidth / 3, color1: color1, color2: color2.opacity(0.3))
                .offset(x: -screenWidth / 5, y: (1 / 3) * -screenHeight)
                .offset(x: offsetX[3], y: offsetY[3])
        }
        .onReceive(timer) { _ in
            withAnimation(.easeIn(duration: 5)) {
                // Randomize X and Y offsets for animation
                for i in 0..<offsetX.count {
                    offsetX[i] = CGFloat.random(in: -300...300)
                }
                for i in 0..<offsetY.count {
                    offsetY[i] = CGFloat.random(in: -300...300)
                }
            }
        }
    }
}

// Preview for FourGradientCircles
struct FourGradientCircles_Previews: PreviewProvider {
    static var previews: some View {
        FourGradientCircles()
    }
}
