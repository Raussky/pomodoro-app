//
//  Settings.swift
//  PomodoroApp
//
//  Created by Admin on 21.04.2023.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var timerSettings = TimerSettings()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.bottom,50)
            HStack{
                Text("Focus Time")
                    .foregroundColor(.white)
                Spacer()
                Picker(selection: $timerSettings.focusTime, label: Text("Focus Time")){
                    ForEach(1...120, id: \.self) { minute in
                        Text("\(minute) minutes")
                    }
                }
                .accentColor(.white)
                .pickerStyle(.menu)
            }
            Divider()
            HStack{
                Text("Break Time")
                    .foregroundColor(.white)
                Spacer()
                Picker(selection: $timerSettings.breakTime, label: Text("Break Time")) {
                    ForEach(1...60, id: \.self) { minute in
                        Text("\(minute) minutes")
                    }
                }
                .accentColor(.white)
                .pickerStyle(MenuPickerStyle())
            }
            Spacer()
        }
        
        .padding()
        .background{
            Color(red: 0.11, green: 0.11, blue: 0.118)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}




struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
