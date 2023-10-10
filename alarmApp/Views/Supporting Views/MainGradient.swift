import SwiftUI

// MainGradient is a custom view for a combination of linear and radial gradients.
struct MainGradient: View {
    var startRadius: CGFloat = 0.0 // Starting radius for radial gradient
    let endRadius: CGFloat // Ending radius for radial gradient
    var scaleX: CGFloat = 2.0 // Scale factor for the radial gradient
    var opacityLinGrad = 0.5 // Opacity for the linear gradient
    var opacityRadGrad = 0.5 // Opacity for the radial gradient
    var defaultColor = blue // Default color for the gradients
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [blue, yellow, gray], startPoint: .top, endPoint: .bottom) // Create a linear gradient
                .opacity(opacityLinGrad) // Set opacity for the linear gradient
            
            RadialGradient(colors: [orange, pink, .clear], center: .bottom, startRadius: startRadius, endRadius: endRadius) // Create a radial gradient
                .opacity(opacityRadGrad) // Set opacity for the radial gradient
                .scaleEffect(x: scaleX) // Apply scale effect to the radial gradient
        }
    }
}

// Preview for MainGradient
struct MainGradient_Previews: PreviewProvider {
    static var previews: some View {
        MainGradient(endRadius: 80) // Preview the MainGradient with a specified ending radius
            .frame(width: screenWidth, height: 100) // Set the frame width and height
    }
}
