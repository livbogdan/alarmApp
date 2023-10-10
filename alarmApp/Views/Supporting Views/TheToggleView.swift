import SwiftUI

// TheToggleView is a custom toggle switch view.
struct TheToggleView: View {
    var width = 35.0 // Width of the toggle switch
    let factor = 59.0/35.0 // Factor used for calculations
    let innerCircleFactor = 59.0/25.0 // Factor for inner circle size
    
    @Binding var isOn: Bool // Binding to track the state of the toggle switch
    
    let offsetDelta = 12.0 // Offset used for shifting elements
    
    var sign: Double {
        isOn ? 1.0 : -1.0 // Determines the sign based on the toggle state
    }
    
    var xShift: Double {
        return sign * offsetDelta // Calculates the horizontal shift based on the sign
    }
    
    var backgroundWhiteness: Double {
        var result = xShift + offsetDelta
        result = result / (2.0 * offsetDelta)
        
        result = result * 0.5
        
        result = 0.5 - result
        return result
    }
    
    var textColor: Color {
        isOn ? nickel : black // Text color based on the toggle state
    }
    
    var onOffText: LocalizedStringKey {
        isOn ? "On" : "Off" // Text to display based on the toggle state
    }
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { gesture in
                withAnimation(.easeIn(duration: 0.2)){
                    isOn = gesture.translation.width > 0 ? true : false
                }}
        let tapGesture = TapGesture()
            .onEnded{_ in  withAnimation(.easeIn(duration: 0.2)){
                isOn.toggle()
            }}
        
        let combinedGesture = dragGesture
            .simultaneously(with: tapGesture)
        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(white: backgroundWhiteness)) // Background of the toggle switch
            
            ShiftedText(text: onOffText, color: textColor, xShift: -xShift) // Displayed text
            
            ShiftedCircle(xShift: xShift) // A circle element
        }
        .frame(width: width*factor, height: width, alignment: .leading) // Set the frame size and alignment
        .gesture(combinedGesture) // Apply the combined gesture
    }
}

// ShiftedText is a view for displaying text with a horizontal shift.
struct ShiftedText: View {
    let text: LocalizedStringKey // Text to display
    let color: Color // Text color
    let xShift: Double // Horizontal shift
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.custom("Alcatraz", size: 10)) // Custom font and size
            .offset(x: xShift) // Apply the horizontal shift
    }
}

// ShiftedCircle is a view for displaying a circle with a horizontal shift.
struct ShiftedCircle: View {
    var color: Color = cardBackgroundColor // Circle color
    let xShift: Double // Horizontal shift
    var padding: Double = 7.0 // Padding around the circle
    
    var body: some View {
        Circle()
            .fill(color)
            .padding(padding) // Apply padding
            .offset(x: xShift) // Apply the horizontal shift
    }
}

// Preview for TheToggleView
struct TheToggleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TheToggleView(isOn: .constant(true)) // Preview for the toggle switch in the "On" state
            TheToggleView(isOn: .constant(false)) // Preview for the toggle switch in the "Off" state
        }
    }
}
