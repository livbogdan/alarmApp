
import SwiftUI

// SoundMenuView is a view for selecting the sound for an alarm
struct SoundMenuView: View {

    @Binding var alarmSound: Sounds // Binding to track the selected alarm sound

    var body: some View {
        
        Form {
        
            // Section for Hip Hop sounds
            Section(header: Text("Hip Hop Beat")) {

                ForEach(hipHopbeatList, id: \.self) { sound in
                
                    Button(action: {
                        alarmSound = sound // Update binding with selected sound
                        playSound(sound: sound.rawValue) // Play preview of sound
                    }, label: {
                        
                        HStack {
                            // Show checkmark icon for selected sound
                            Image(systemName: "checkmark")
                                .foregroundColor(black)
                                .opacity(alarmSound == sound ? 1.0 : 0.0)
                                
                            Text(sound.rawValue.formatSoundName) // Display name of sound
                                .foregroundColor(gray)
                                .fontWeight(.semibold)
                        }
                    })
                }
            }
            
            // Section for Kik sounds
            Section(header: Text("Kik Beat")) {
            
                // Same pattern as above section
                ForEach(kikBeatList, id: \.self) { sound in
                    Button(action: {
                        alarmSound = sound
                        playSound(sound: sound.rawValue)
                    }, label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundColor(black)
                                .opacity(alarmSound == sound ? 1.0 : 0.0)
                            Text(sound.rawValue.formatSoundName)
                                .foregroundColor(gray)
                                .fontWeight(.semibold)
                        }
                    })
                }
            }
            
        }
        .onDisappear {
            stopPlaying() // Stop any playing sounds when view disappears
        }
    }
}

// View for displaying SoundMenuView from a button
struct SoundMenuViewFromButton: View {

    @Binding var alarmModel: AlarmModel

    var body: some View {

        NavigationLink(destination: {
            SoundMenuView(alarmSound: $alarmModel.sound)
        }, label: {
            
            // Button content
            HStack {
                Text("Sound")
                    .fontWeight(.semibold)
                    
                Text(alarmModel.sound.rawValue.formatSoundName)
                    .font(.caption)
                    .fontWeight(.thin)
            }
            .padding(7)
            .overlay(Capsule().stroke())
            
        })
    }
}
