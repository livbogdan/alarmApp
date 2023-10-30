
import SwiftUI

// Define a SwiftUI view called ListOfTheAlarmsView
struct ListOfTheAlarmsView: View {
    
    /// Input data: an array of AlarmModel
    //var alarmViewModel: [AlarmModel]
    @EnvironmentObject var lnManager: LocalNotificationManager
    
    @State var isActive = false
    @State var currentIndex: Int? = nil
    
    var body: some View {
        // Create a navigation stack
        NavigationStack {
            ZStack {
                // Create a list to display alarms
                List {
                    ForEach(0..<lnManager.alarmViewModels.count, id: \.self) {
                        i in
                        
                        Button(action: {
                            currentIndex = i
                            isActive.toggle()
                        }, label: {
                            AlarmRowMenu(model: lnManager.alarmViewModels[i], i: i) // Display the alarm row menu
                                .padding(.vertical)
                        })
                    }
                    .onDelete(perform: deleteMe)
                }
                
                // Display four gradient circles with reduced opacity
                FourGradientCircles()
                    .opacity(0.1) // Set the opacity of the gradient circles
            }
                .navigationTitle("Alarm List") // Set the navigation title
                .toolbar {
                    // Add a button to add a new alarm
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: {
                            // Display the AddEditAlarmView with a new alarm
                            MainAddEditView(currentAlarmIndex: nil, alarmModel: .DefaultAlarm())
                        }, label: {
                            Text("Add") // Comment: Label for the button to add a new alarm
                                ///.font(.largeTitle)
                                .fontWeight(.semibold)
                                ///.foregroundColor(gray) // Assuming 'gray' is defined somewhere
                        })
                    }
                    
                    // Add an edit button to edit the list
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton() // Add an edit button to allow list editing
                    }
                }
        }
    }
    
    func deleteMe(offsets: IndexSet) {
        for index in offsets {
            print("remove requestfrom \(lnManager.alarmViewModels[index].id)")
            lnManager
                .removeRequest(id: lnManager.alarmViewModels[index].id
                )
        }
        
        lnManager.alarmViewModels.remove(atOffsets: offsets)
    }
}

// Define a preview for ListOfTheAlarmsView
struct ListOfTheAlarmsView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the ListOfTheAlarmsView with dummy data
        ListOfTheAlarmsView()
            .environmentObject(LocalNotificationManager())
    }
}
