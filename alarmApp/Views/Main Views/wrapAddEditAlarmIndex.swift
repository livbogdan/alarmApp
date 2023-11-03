
import SwiftUI

enum AddEditViewType {
    case Standard, Circular
}

struct wrapAddEditAlarmIndex: View {
    @Binding var currentAlarmIndex: Int?
    @EnvironmentObject var lnManager: LocalNotificationManager
    let addEditViewType: AddEditViewType
    
    var body: some View {
        if let currentAlramIndex = currentAlarmIndex {
            if addEditViewType == .Standard {
                
                // Display the AddSaveMangeView
                AddEditAlarmView(currentAlramIndex: currentAlarmIndex, alarmModel: lnManager.alarmViewModels[currentAlramIndex])
            }else{
                AddEditCircularAlarmView(currentAlarmIndex: currentAlarmIndex, alarmModel: lnManager.alarmViewModels[currentAlramIndex])
            }
            
        }else {
            if addEditViewType == .Standard {
                AddEditAlarmView(currentAlramIndex: currentAlarmIndex, alarmModel: .DefaultAlarm())
            }else{
                AddEditCircularAlarmView(currentAlarmIndex: currentAlarmIndex, alarmModel: .DefaultAlarm())
            }
            
        }
    }
}

struct wrapAddEditAlarmIndex_Previews: PreviewProvider {
    static var previews: some View {
        wrapAddEditAlarmIndex(currentAlarmIndex: .constant(nil), addEditViewType: .Standard)
            .environmentObject(LocalNotificationManager())
    }
}
