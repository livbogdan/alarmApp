import Foundation

// MARK: - User Model

struct User: Identifiable, Codable {

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

extension User {

    // Mock user for testing
    static var MOC_USER = User(id: NSUUID().uuidString, fullName: "Bogdan", email: "bogdan@livanov")

}
