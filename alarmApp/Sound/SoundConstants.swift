import Foundation

// Define an enum to represent different alarm sounds
enum Sounds: String, CaseIterable, Codable {
    case beat_mixed_full = "beat-mixed-full.wav" // A sound option for waking up
    case mixed_hip_hop_beat = "mixed-hip-hop-beat-full.wav" // Another sound option
    case kick_and_snare_hip_hop = "kick-and-snare-hip-hop-style-noisy.wav"
    
    // Function to format the sound name for display
    
}

let hipHopbeatList: [Sounds] = [
    .beat_mixed_full,
    .mixed_hip_hop_beat
]

let kikBeatList: [Sounds] = [
    .kick_and_snare_hip_hop
]

extension String {
    var formatSoundName: String {
        var result = String(describing: self) // Convert enum case to string
            .replacingOccurrences(of: "-", with: " ") // Replace underscores with spaces
            .capitalized // Capitalize the first letter of each word
        let periodIndex = result.firstIndex(of: ".")
        
        if let periodIndex: Index = periodIndex {
            result.removeSubrange(periodIndex...)
        }
        
        return result
    }
}
