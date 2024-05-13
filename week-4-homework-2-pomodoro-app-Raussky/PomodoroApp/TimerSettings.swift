//
//  TimerSettings.swift
//  PomodoroApp
//
//  Created by Admin on 21.04.2023.
//

import SwiftUI

class TimerSettings: ObservableObject {
    @Published var timeRemaining: Int = 0
    @Published var isRunning = false
    @Published var isPaused = false
    @Published var focusTime: Int = 25
    @Published var breakTime: Int = 5
    @Published var progress: CGFloat = 0.0
    @Published var backgroundIndex = 0
    @Published var summaries: [String: DailySummary] = [:]
    
    func startTimer() {
        if !isRunning {
            timeRemaining = focusTime * 60 // convert to seconds
            isRunning.toggle()
        }
    }
    
    func resetTimer() {
        isRunning = false
        isPaused = false
        timeRemaining = 0
    }
    
    func timeString(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "dailySummaries"), let summaries = try? JSONDecoder().decode([String: DailySummary].self, from: data) {
            self.summaries = summaries
        }
    }
    
    func addSummary(for date: Date) {
        let dateString = Self.dateFormatter.string(from: date)
        let summary = DailySummary(focusTime: Double(self.focusTime), breakTime: Double(self.breakTime))
        summaries[dateString] = summary
        UserDefaults.standard.set(try? JSONEncoder().encode(summaries), forKey: "dailySummaries")
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

