
import SwiftUI

struct MainAddEditView: View {
    let currentAlarmIndex: Int?
    @State var alarmModel: AlarmModel
    
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab){
            AddEditAlarmView(currentAlramIndex: currentAlarmIndex, alarmModel: alarmModel)
                .tag("One")
            AddEditCircularAlarmView(currentAlarmIndex: currentAlarmIndex, alarmModel: alarmModel)
                .tag("Two")
        }
        .onAppear(){
            UIPageControl
                .appearance()
                .currentPageIndicatorTintColor = .blue
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea()
    }
}

struct MainAddEditView_Previews: PreviewProvider {
    static var previews: some View {
        MainAddEditView(currentAlarmIndex: nil, alarmModel: .DefaultAlarm())
    }
}
