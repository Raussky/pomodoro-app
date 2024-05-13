//
//  PomodoroAppApp.swift
//  PomodoroApp
//
//  Created by Admin on 21.04.2023.
//

import SwiftUI

@main
struct PomodoroAppApp: App {
    @StateObject var timerSettings = TimerSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
                    .environmentObject(timerSettings)
        }
    }
}
