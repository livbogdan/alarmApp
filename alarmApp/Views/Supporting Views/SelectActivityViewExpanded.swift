import SwiftUI

struct SelectActivityViewExpanded: View {
    @Binding var currentColorIndex: Int // Binding to the index of the currently selected color
    @Binding var currentActivity: String // Binding to the currently selected activity

    var circleFrame = 30.0 // Adjust the circle frame size

    var currentColor: Color {
        mainColors[currentColorIndex] // Get the color associated with the current index
    }

    var body: some View {
        VStack {
            // Row of Circles for selecting Color
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    // Loop through mainColors to create color selection circles
                    ForEach(0 ..< mainColors.count, id: \.self) { item in
                        let color = mainColors[item]
                        let isSelectedColor = color == currentColor

                        Circle()
                            .fill(color)
                            .frame(width: circleFrame, height: circleFrame)
                            .shadow(color: color.opacity(0.7), radius: 10, x: 2, y: 2)
                            .scaleEffect(isSelectedColor ? 1.1 : 1.0)
                            .overlay(
                                Circle()
                                    .stroke(lineWidth: isSelectedColor ? 3 : 0.5) // Add stroke to the selected circle
                            )
                            .onTapGesture {
                                withAnimation {
                                    currentColorIndex = item // Update the selected color index
                                }
                            }
                    }
                }
                .frame(height: 50)
                .padding()
            }

            // Row of Icons for selecting activity
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    // Loop through activities to create activity selection icons
                    ForEach(activities, id: \.self) { activity in
                        let isSelectedActivity = activity == currentActivity

                        Image(systemName: activity)
                            .font(isSelectedActivity ? .largeTitle : .title2)
                            .foregroundColor(isSelectedActivity ? currentColor : nickel)
                            .opacity(isSelectedActivity ? 1.0 : 0.7)
                            .onTapGesture {
                                withAnimation {
                                    currentActivity = activity // Update the selected activity
                                }
                            }
                            .padding(5)
                            .background(
                                Circle()
                                    .fill(isSelectedActivity && currentColor != white ? black.opacity(0.2) : .clear)
                            )
                            .overlay(
                                Circle()
                                    .stroke(isSelectedActivity ? currentColor : black, lineWidth: isSelectedActivity ? 1 : 0.0)
                            )
                    }
                }
                .frame(height: 50)
                .padding()
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(nickel, lineWidth: 1)
        )
    }
}

struct SelectActivityViewExpanded_Previews: PreviewProvider {
    static var previews: some View {
        SelectActivityViewExpanded(currentColorIndex: .constant(0), currentActivity: .constant(activities[0]))
            .padding(.horizontal)
    }
}
