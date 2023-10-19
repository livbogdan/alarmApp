import SwiftUI

struct MainAlarmView: View {
    @EnvironmentObject var lnManager: LocalNotificationManager
    
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        TabView {
            //AddSaveMangeView(currentAlramIndex: nil, alarmModel: .DefaultAlarm())
            if lnManager.isAuthorized {
                ListOfTheAlarmsView(alarmViewModel: AlarmModel.DummyAlarmDate())
                    .tabItem({
                        Label("Alarms", systemImage: "alarm.fill")
                    })
            } else {
                EnableNotifications()
            }
        }
        .ignoresSafeArea()
        .task {
            try? await lnManager
                .requestAuthorization()
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                Task{
                    await lnManager
                        .getCurrentSetting()
                    
                    await lnManager
                        .getPendingAlarm()
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAlarmView()
    }
}
