//
//  ContentView.swift
//  PomodoroApp
//
//  Created by Admin on 21.04.2023.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var timerSettings = TimerSettings()
    
    var body: some View {
        TabView {
            Home()
                .environmentObject(timerSettings)
                .tabItem {
                    Image("first")
                }
            Settings()
                .environmentObject(timerSettings)
                .tabItem {
                    Image("second")
                }
            History()
                .environmentObject(timerSettings)
                .tabItem {
                    Image("third")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
