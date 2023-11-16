import Foundation

// MARK: - User Model

struct Users: Identifiable, Codable {

    // Properties
    let id: String
    let fullName: String
    let email: String
    
    // Computed property to get initials from full name
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

// MARK: - Mock User Extension

extension Users {

    // Mock user for testing
    static var MOC_USER = Users(id: NSUUID().uuidString, fullName: "Bogdan", email: "bogdan@livanov")

}
