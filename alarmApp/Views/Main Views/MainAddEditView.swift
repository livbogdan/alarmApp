import SwiftUI

struct MainAddEditView: View {

  // Property to pass in current alarm index being edited
  let currentAlarmIndex: Int?
  
  // State property to store the alarm model data
  @State var alarmModel: AlarmModel

  // State property to track selected tab 
  @State private var selectedTab = "One"

  var body: some View {

    // Tab view to switch between different edit views
    TabView(selection: $selectedTab){

      // First tab shows default edit view
      AddEditAlarmView(currentAlramIndex: currentAlarmIndex, alarmModel: alarmModel)
        .tag("One")

      // Second tab shows circular edit view
      AddEditCircularAlarmView(currentAlarmIndex: currentAlarmIndex, alarmModel: alarmModel)
        .tag("Two")

    }
    
    // Set tab indicator color
    .onAppear(){
      UIPageControl
        .appearance()
        .currentPageIndicatorTintColor = .blue
    }
    
    // Use page style tabs 
    .tabViewStyle(.page(indexDisplayMode: .always))
    
    // Ignore safe area
    .ignoresSafeArea()

  }

}

struct MainAddEditView_Previews: PreviewProvider {
  static var previews: some View {
    MainAddEditView(currentAlarmIndex: nil, alarmModel: .DefaultAlarm())
  }
}

