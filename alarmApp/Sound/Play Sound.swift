
import Foundation
import AVFoundation

// Property to store the AVAudioPlayer instance
var audioPlayer: AVAudioPlayer? = AVAudioPlayer()

// Function to play a sound
func playSound(sound: String, type: String = "", volume: Float = 1.0) {

    // Get path to sound file from app bundle
    if let path = Bundle.main.path(forResource: sound, ofType: type) {

        do {
            // Try creating AVAudioPlayer instance from file path
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            // Set volume and start playback
            audioPlayer?.setVolume(volume, fadeDuration: 0.1)
            audioPlayer?.play()
            
        } catch {
            // Handle error creating player
            print("audio Error")
        }

    }
}

// Function to stop audio playback
func stopPlaying() {
    audioPlayer?.stop()
}

