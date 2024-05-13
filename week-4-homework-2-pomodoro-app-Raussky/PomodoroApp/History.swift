//
//  History.swift
//  PomodoroApp
//
//  Created by Admin on 21.04.2023.
//

import SwiftUI

struct DailySummary: Codable {
    var focusTime: Double
    var breakTime: Double
}

//class DailySummaries: ObservableObject {
//    @Published var summaries: [String: DailySummary] = [:]
//    
//    init() {
//        if let data = UserDefaults.standard.data(forKey: "dailySummaries"), let summaries = try? JSONDecoder().decode([String: DailySummary].self, from: data) {
//            self.summaries = summaries
//        }
//    }
//    
//    func addSummary(for date: Date, focusTime: Double, breakTime: Double) {
//        let dateString = Self.dateFormatter.string(from: date)
//        let summary = DailySummary(focusTime: focusTime, breakTime: breakTime)
//        summaries[dateString] = summary
//        UserDefaults.standard.set(try? JSONEncoder().encode(summaries), forKey: "dailySummaries")
//    }
//    
//    private static let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
//}

struct History: View {
    @ObservedObject var dailySummaries = TimerSettings()
    
    var body: some View {
        VStack {
            Button("Add summary for today") {
                let now = Date()
                dailySummaries.addSummary(for: now)
            }
            Text("History")
                .foregroundColor(.white)
            List(dailySummaries.summaries.sorted(by: { $0.key > $1.key }), id: \.key) { date, summary in
                VStack(alignment: .leading) {
                    Text(date)
                        .font(.headline)
                    Text("Focus time: \(summary.focusTime, specifier: "%.1f") minutes")
                    Text("Break time: \(summary.breakTime, specifier: "%.1f") minutes")
                }
            }
            
        }
        .background{
            Color(red: 0.11, green: 0.11, blue: 0.118)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}




//struct History: View {
//    struct DaySummary: Codable {
//        let date: Date
//        var focusTime: Int
//        var breakTime: Int
//
//        init(date: Date, focusTime: Int, breakTime: Int) {
//            self.date = date
//            self.focusTime = focusTime
//            self.breakTime = breakTime
//        }
//    }
//
//    var daySummaries: [DaySummary] {
//        let summaries: [Data]? = UserDefaults.standard.array(forKey: "daySummaries") as? [Data]
//        let decoder = JSONDecoder()
//        let daySummaries = summaries?.compactMap { try? decoder.decode(DaySummary.self, from: $0) } ?? []
//        return daySummaries
//    }
//
//    var body: some View {
//        List(daySummaries, id: \.date) { summary in
//            VStack(alignment: .leading) {
//                Text(summary.date, style: .date)
//                HStack {
//                    Text("Focus time: \(timeString(summary.focusTime))")
//                    Spacer()
//                    Text("Break time: \(timeString(summary.breakTime))")
//                }
//            }
//        }
//        .background(Color.black)
//    }
//
//    private func timeString(_ seconds: Int) -> String {
//        let minutes = seconds / 60
//        let remainderSeconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, remainderSeconds)
//    }
//}


struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
