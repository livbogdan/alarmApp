import SwiftUI

struct AlarmRowMenuButton: View {
    @EnvironmentObject var lnManager: LocalNotificationManager
    let model: AlarmModel
    let i: Int
    @Binding var currentIndex: Int?
    @Binding var isActive: Bool
    
    var body:  some View {
        HStack(spacing: 20) {
            Button(action: {
                currentIndex = i
                isActive.toggle()
            }, label: {
                HStack {
                    // Display an image based on the activity from the AlarmModel
                    Image(systemName: model.activity)
                        .foregroundColor(model.activityColor) // Set the image color
                        .font(.title) // Set the font size to .title

                    Spacer()
                    
                    // Display the time from the AlarmModel
                    Text("\(getTimeFromDate(date: model.start)) - \(getTimeFromDate(date: model.end))")
                        .font(.title) // Set the font size to .title
                        .fontWeight(model.alarmEnabled ? .regular : .thin) // Set font weight based on alarmEnabled
                        .scaleEffect(model.alarmEnabled ? 1.05 : 1.1) // Adjust scale based on alarmEnabled
                        .opacity(model.alarmEnabled ? 1.0 : 0.7) // Adjust opacity based on alarmEnabled

                }
        })
            
            Spacer() // Add a flexible space to push the toggle view to the right

            // Create a toggle view with a binding to the 'alarmEnabled' property of an AlarmModel
           
            if i < lnManager.alarmViewModels.count {
                TheToggleView(isOn: $lnManager.alarmViewModels[i].alarmEnabled)
            }
        }
        .onChange(of: model.alarmEnabled) {
            alarmEnabled in
            if alarmEnabled {
                print("enable alarm")
                Task {
                    await lnManager
                        .schedule(localNotification: model)
                }
            } else {
                print("disable alarm")
                lnManager
                    .removeRequest(id: model.id)
            }
        }
    }
}

struct AlarmRowMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the AlarmRowMenu with a default AlarmModel and index 0
        AlarmRowMenuButton(model: .DefaultAlarm(), i: 0, currentIndex: .constant(0), isActive: .constant(false))
            .environmentObject(LocalNotificationManager())
    }
}
