import Foundation

// Define an enum to represent different alarm sounds
enum Sounds: String, CaseIterable {
    case wake_up = "Sound Wake Up" // A sound option for waking up
    case lagrima = "Lagrima" // Another sound option
    
    // Function to format the sound name for display
    func formatSoundName() -> String {
        String(describing: self) // Convert enum case to string
            .replacingOccurrences(of: "_", with: " ") // Replace underscores with spaces
            .capitalized // Capitalize the first letter of each word
    }
}
