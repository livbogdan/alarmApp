import SwiftUI

// AddSaveMangeView is a view for managing and saving alarm settings.
struct AddSaveMangeView: View {
    let currentAlramIndex: Int? // Optional index of the current alarm
    @State var alarmModel: AlarmModel // State variable to store alarm settings
    
    var body: some View {
        NavigationStack {
            VStack {

                CancelSaveAlarm(currenAlarmIndex: currentAlramIndex, alarmModel: $alarmModel) // Display CancelSaveAlarm view
                //Text("Toogle Alarm") // Display text for toggling the alarm
                AlarmToggleView(alarmEnable: $alarmModel.alarmEnabled)
                
                Divider() // Add a divider
                
                HStack {
                    Grid { // Create a grid for organizing alarm settings
                        GridRow {
                            TimeOfDayIcon(date: alarmModel.start)
                                .font(.largeTitle) // Display the start time of the alarm
                            VStack(alignment: .leading) {
                                // Display "Start" label
                                GrayTextView(text: "Start")
                                
                                // Display the TimePicker for selecting the alarm's start time
                                TimePicker(time: $alarmModel.start, scale: 1.3)
                            }
                        }
                        
                        GridRow {
                            HStack {
                                Divider()
                                    .frame(height: 30)
                                    .padding(2)
                                    .background(nickel) // Display a horizontal line divider
                            }
                        }
                        
                        GridRow {
                            // Display the selected activity icon
                            Image(systemName: alarmModel.activity)
                                .foregroundColor(alarmModel.activityColor)
                                .font(.largeTitle)
                            SelectActivityView(currentColorIndex: $alarmModel.colorIndex,
                                               currentActivity: $alarmModel.activity)
                        }
                        .padding(.vertical)
                        
                        GridRow {
                            HStack {
                                Divider()
                                    .frame(height: 30)
                                    .padding(2)
                                    .background(nickel) // Display a horizontal line divider
                            }
                        }
                        
                        GridRow {
                            TimeOfDayIcon(date: alarmModel.end)
                                .font(.largeTitle) // Display the end time of the alarm
                            VStack(alignment: .leading) {
                                GrayTextView(text: "End") // Display "End" label
                                // Display the TimePicker for selecting the alarm's start time
                                TimePicker(time: $alarmModel.end, scale: 1.3)
                            }.padding(.vertical)
                        }
                        
                        GridRow {
                            Text("")
                            SoundMenuViewFromButton(alarmModel: $alarmModel)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Set grid frame properties
                }
                .padding() // Apply padding to the HStack
            }
            .padding()
            .background(cardBackgroundColor
                .cornerRadius(20)
                .opacity(0.3)) // Apply background styling
        .padding()
        }
    }
}

// Preview for AddSaveMangeView
struct AddSaveMangeView_Previews: PreviewProvider {
    static var previews: some View {
        AddSaveMangeView(currentAlramIndex: nil, alarmModel: .DefaultAlarm()) // Preview with default alarm settings
    }
}
