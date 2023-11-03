
import SwiftUI

// Define a SwiftUI view called ListOfTheAlarmsView
struct ListOfTheAlarmsView: View {
    
    /// Input data: an array of AlarmModel
    //var alarmViewModel: [AlarmModel]
    @EnvironmentObject var lnManager: LocalNotificationManager
    
    @State var isActive = false
    @State var currentIndex: Int? = nil
    @State var addEditViewType: AddEditViewType = .Standard
    
    var body: some View {
        // Create a navigation stack
        NavigationStack {
            ZStack {
                // Create a list to display alarms
                VStack {
                    List {
                        ForEach(lnManager.alarmViewModels.indices, id: \.self) {
                            i in
                            
                            AlarmRowMenuButton(model: lnManager.alarmViewModels[i], i: i, currentIndex: $currentIndex,isActive: $isActive)
                                // Display the alarm row menu
                        }
                        .onDelete(perform: deleteMe)
                    }
                    
                    SelectView(width: 50, addEditViewType: $addEditViewType, isActive: $isActive)
                }
                
                // Display four gradient circles with reduced opacity
                FourGradientCircles()
                    .opacity(0.1) // Set the opacity of the gradient circles
            }
                .navigationTitle("Alarm List") // Set the navigation title
                .sheet(isPresented: $isActive,
                       onDismiss: {}){
                    wrapAddEditAlarmIndex(currentAlarmIndex: $currentIndex, addEditViewType: addEditViewType)
                }
                .toolbar {
                    // Add a button to add a new alarm
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button(action: {
                            isActive.toggle()
                        }, label: {
                            Text("Add") // Comment: Label for the button to add a new alarm
                                .fontWeight(.semibold)
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
