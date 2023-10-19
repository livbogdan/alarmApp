
import Foundation
import NotificationCenter

@MainActor
class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isAuthorized = false
    
    @Published var pendingAlarms: [UNNotificationRequest] = []
    
    @Published var alarmViewModels: [AlarmModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemKey = "Alarm List"
    
    func requestAuthorization() async throws {
        try await notificationCenter
            .requestAuthorization(options: [.sound, .badge, .alert])
        
        await getCurrentSetting()
    }
    
    func getCurrentSetting() async {
        let currentSettings = await notificationCenter.notificationSettings()
        
        isAuthorized = currentSettings.authorizationStatus == .authorized
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
    
    //save state for alarm view Model
    func saveItems() {
        if let encodeData = try? JSONEncoder()
            .encode(alarmViewModels) {
            UserDefaults
                .standard
                .set(encodeData, forKey: itemKey)
            
        }
    }
    
    override init() {
        super.init()
        //TODO: want alarm togo off when app is also active
        
        // Alarm view Model  persistance
        guard let data = UserDefaults
            .standard
            .data(forKey: itemKey),
                let savedItems = try? JSONDecoder()
            .decode([AlarmModel].self, from: data)
        else {
            return
        }
        self.alarmViewModels = savedItems
    }
    
    func getPendingAlarm() async {
        pendingAlarms = await notificationCenter
            .pendingNotificationRequests()
    }
}
