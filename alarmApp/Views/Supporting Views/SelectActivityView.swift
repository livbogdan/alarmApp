import SwiftUI

// SelectActivityView is a SwiftUI view for selecting an activity and its color.
struct SelectActivityView: View {
    @Binding var currentColorIndex: Int // Binding to the index of the currently selected color
    @Binding var currentActivity: String // Binding to the currently selected activity

    var currentColor: Color {
        mainColors[currentColorIndex] // Get the color associated with the current index
    }
    
    var nextIndex: Int {
        (currentColorIndex + 1) % mainColors.count // Calculate the index for the next color
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(activities, id: \.self) { activity in
                        let isSelectedActivity = activity == currentActivity
                        
                        // Display an activity icon with interactivity
                        Image(systemName: activity)
                            .font(isSelectedActivity ? .largeTitle : .subheadline)
                            .foregroundColor(isSelectedActivity ? currentColor : nickel)
                            .opacity(isSelectedActivity ? 1.0 : 0.7)
                            .onTapGesture {
                                withAnimation {
                                    currentActivity = activity // Update the selected activity
                                }
                            }
                    }
                }
            }
            
            // Display a colored circle for selecting the color
            Circle()
                .fill(currentColor)
                .frame(width: 30, height: 30)
                .shadow(color: currentColor.opacity(0.8), radius: 10, x: 0, y: 5)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3))
                .onTapGesture {
                    withAnimation {
                        currentColorIndex = nextIndex // Update the selected color
                    }
                }
        }
    }
}

// Preview for SelectActivityView
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the SelectActivityView with initial color and activity
        SelectActivityView(currentColorIndex: .constant(0), currentActivity: .constant(activities[0]))
            .padding(.horizontal)
    }
}
