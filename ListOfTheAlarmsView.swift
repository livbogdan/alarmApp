
import SwiftUI

// Define a SwiftUI view called ListOfTheAlarmsView
struct ListOfTheAlarmsView: View {
    
    // Input data: an array of AlarmModel
    var alarmViewModel: [AlarmModel]
    
    var body: some View {
        // Create a navigation stack
        NavigationStack {
            ZStack {
                // Create a list to display alarms
                List {
                    ForEach(0..<alarmViewModel.count, id: \.self) {
                        i in
                        let alarmModel = alarmViewModel[i]
                        
                        // Create a navigation link to edit individual alarms
                        NavigationLink(destination: {
                            // Display the AddEditAlarmView with parameters
                            AddEditAlarmView(currentAlramIndex: i, alarmModel: alarmModel)
                            
                        }, label: {
                            HStack {
                                // Display an image and text for each alarm
                                Image(systemName: alarmModel.activity)
                                    .foregroundColor(alarmModel.activityColor)
                                
                                //AlarmRowMenu()
                                Text("Alarm row view - Edit me")
                            }
                        })
                    }
                }
                
                // Display four gradient circles with reduced opacity
                FourGradientCircles()
                    .opacity(0.3)
            }
                .navigationTitle("Alarm List") // Set the navigation title
                .toolbar {
                    // Add a button to add a new alarm
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: {
                            // Display the AddEditAlarmView with a new alarm
                            AddEditAlarmView(currentAlramIndex: nil, alarmModel: .DefaultAlarm())
                        }, label: {
                            Text("+")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(gray) // Assuming 'gray' is defined somewhere
                        })
                    }
                    
                    // Add an edit button to edit the list
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
        }
    }
}

// Define a preview for ListOfTheAlarmsView
struct ListOfTheAlarmsView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the ListOfTheAlarmsView with dummy data
        ListOfTheAlarmsView(alarmViewModel: AlarmModel.DummyAlarmDate())
    }
}
