import Foundation
import NotificationCenter

@MainActor
class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {

    // MARK: - Properties
    
    // UNUserNotificationCenter for managing notifications
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Published property to track notification authorization status
    @Published var isAuthorized = false
    
    // Published array to store pending notification requests
    @Published var pendingAlarms: [UNNotificationRequest] = []
    
    // Published array to store AlarmModel instances
    @Published var alarmViewModels: [AlarmModel] = []
    
    // Key for storing alarm data in UserDefaults
    let itemKey = "Alarm List"
    
    // MARK: - Authorization
    
    // Request notification authorization
    func requestAuthorization() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSetting()
    }
    
    // Get current notification settings
    func getCurrentSetting() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isAuthorized = currentSettings.authorizationStatus == .authorized
    }
    
    // MARK: - Notification Settings
    
    // Open notification settings
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            Task {
                await UIApplication.shared.open(url)
            }
        }
    }
    
    // MARK: - Data Persistence
    
    // Save AlarmModels to UserDefaults
    func saveItems() {
        if let data = try? JSONEncoder().encode(alarmViewModels) {
            UserDefaults.standard.set(data, forKey: itemKey)
        }
    }
    
    // Init - load saved data
    override init() {
        super.init()
        
        // Load saved AlarmModel data from UserDefaults
        guard let data = UserDefaults.standard.data(forKey: itemKey),
              let savedItems = try? JSONDecoder().decode([AlarmModel].self, from: data)
        else { return }
        
        alarmViewModels = savedItems
    }
    
    // MARK: - Notifications
    
    // Get pending notifications
    func getPendingAlarm() async {
        pendingAlarms = await notificationCenter.pendingNotificationRequests()
    }
    
    // Schedule a local notification using an AlarmModel
    func schedule(localNotification: AlarmModel) async {
        let content = UNMutableNotificationContent()
        
        // Set notification body and sound
        content.body = NSLocalizedString(localNotification.body, comment: "")
        content.sound = customSound(soundName: localNotification.sound)
        
        let dateComponents = localNotification.endDateComponents
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: localNotification.repeats)
        
        let request = UNNotificationRequest(
            identifier: localNotification.id,
            content: content,
            trigger: trigger)
        
        // Attempt to add the notification request
        try? await notificationCenter.add(request)
        
        // Update the list of pending alarms
        pendingAlarms = await notificationCenter.pendingNotificationRequests()
    }
    
    // MARK: - Sound
    
    // Custom sound for the notification
    func customSound(soundName: Sounds, fileExtension: String = "") -> UNNotificationSound? {
        let period = fileExtension.isEmpty ? "" : "."
        let filename = "\(soundName.rawValue)\(period)\(fileExtension)"
        
        return UNNotificationSound(named: UNNotificationSoundName(rawValue: filename))
    }
    
    // MARK: - Notification Removal
    
    // Remove a notification request by identifier
    func removeRequest(id: String) {
        // Remove delivered notifications with the specified identifier
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id])
        
        if let index = pendingAlarms.firstIndex(where: {
            $0.identifier == id
        }) {
            // Remove the notification request from the pending alarms array
            pendingAlarms.remove(at: index)
        }
    }
}
