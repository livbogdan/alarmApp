import SwiftUI

// CustomFont is a SwiftUI view for displaying text with a custom font and shadow.
struct CustomFont: View {
    // Custom font name
    let fontName = "Track drift"
    // Text to be displayed
    let text: LocalizedStringKey
    // Font size
    let size: CGFloat
    
    var body: some View {
        Text(text)
            // Set the font to a custom font with the specified size
            .font(Font.custom(fontName, size: size))
            // Add a shadow effect to the text
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 0)
    }
}


struct CustomFont_Previews: PreviewProvider {
    static var previews: some View {
        // Example usage of CustomFont with "Alarm" text and size 30
        CustomFont(text: "Alarm", size: 30)
    }
}
