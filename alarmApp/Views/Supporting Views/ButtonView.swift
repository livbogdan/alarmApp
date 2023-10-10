import SwiftUI

// ButtonView is a custom button view.
struct ButtonView: View {
    let text: LocalizedStringKey // The text displayed on the button
    var endRadius = 40.0 // Gradient background end radius
    var scaleX = 3.0 // Gradient background X scale factor

    var body: some View {
        Text(text)
            .foregroundColor(black) // Set text color to black
            .fontWeight(.heavy) // Apply heavy font weight
            .padding() // Apply padding to the text
            .frame(maxWidth: .infinity) // Set the frame width to maximum
            .background(MainGradient(endRadius: endRadius, scaleX: scaleX)) // Apply gradient background
            .cornerRadius(30) // Round the corners of the button
    }
}

// Preview for ButtonView
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonView(text: "Test") // Preview the button with "Test" text
            ButtonView(text: "Test2") // Preview the button with "Test2" text
            ButtonView(text: "Test3") // Preview the button with "Test3" text
        }.padding() // Apply padding to the VStack
    }
}
