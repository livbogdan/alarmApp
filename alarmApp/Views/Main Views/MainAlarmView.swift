import SwiftUI

struct MainAlarmView: View {
    var body: some View {
        TabView {
            //AddSaveMangeView(currentAlramIndex: nil, alarmModel: .DefaultAlarm())
            ListOfTheAlarmsView(alarmViewModel: AlarmModel.DummyAlarmDate())
                .tabItem({
                    Label("Alarms", systemImage: "alarm.fill")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAlarmView()
    }
}
