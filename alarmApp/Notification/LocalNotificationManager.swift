
import Foundation
import NotificationCenter

@MainActor
class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {

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

  // Open notification settings
  func openSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    if UIApplication.shared.canOpenURL(url) {
      Task {
        await UIApplication.shared.open(url)
      }
    }
  }

  // Save AlarmModels to UserDefaults
  func saveItems() {
    if let data = try? JSONEncoder().encode(alarmViewModels) {
      UserDefaults.standard.set(data, forKey: itemKey)
    }
  }

  // Init - load saved data
  override init() {
    super.init()
    
    guard let data = UserDefaults.standard.data(forKey: itemKey),
          let savedItems = try? JSONDecoder().decode([AlarmModel].self, from: data)
    else { return }

    alarmViewModels = savedItems
  }

  // Get pending notifications
  func getPendingAlarm() async {
    pendingAlarms = await notificationCenter.pendingNotificationRequests()
  }

}

