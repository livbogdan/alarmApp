import SwiftUI
import SwiftUI

struct MainAlarmView: View {
    
    // Create an environment object to access the notification manager
    @EnvironmentObject var lnManager: LocalNotificationManager
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // Get the current app lifecycle scene phase
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        
        Group {
            if authViewModel.userSession != nil {
                TabView {

                    // Comment: Placeholder for AddSaveManageView
                    if lnManager.isAuthorized {
                        
                        // Show list of alarms if notifications are authorized
                        ListOfTheAlarmsView()
                            .tabItem({
                                Label("Alarms", systemImage: "alarm.fill")
                            })

                    } else {
                        
                        // Show view to enable notifications if not authorized
                        EnableNotifications()

                    }

                }
                    .ignoresSafeArea()
                    .task {
                  
                    // Request notification authorization
                    try? await lnManager.requestAuthorization()

                }
                    .onChange(of: scenePhase) { newValue in
                    if newValue == .active {

                        // When scene becomes active
                        
                        Task{
                        
                            // Get current notification settings
                            await lnManager.getCurrentSetting()
                        
                            // Get any pending alarms
                            await lnManager.getPendingAlarm()
                        
                        }
                        
                    }
                }
            } else {
                LogInScreenView()
            }
        }

        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAlarmView()
    }
}
