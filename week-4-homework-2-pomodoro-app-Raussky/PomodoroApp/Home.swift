//
//  Home.swift
//  PomodoroApp
//
//  Created by Admin on 21.04.2023.
//

import SwiftUI

struct Home: View {
    @ObservedObject var timerSettings = TimerSettings()
    @State private var selectedCategory: String? = nil
    @State private var showingFocusCategorySheet = false
    
    var body: some View {
        VStack(spacing: 60){
            Button(action: {
                showingFocusCategorySheet = true
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 154)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 170,height: 36)
                    HStack{
                        Image("Vector")
                            .font(.system(size: 24))
                        Text("Focus Category")
                            .foregroundColor(.white)
                            .padding(.leading,10)
                    }
                }
            })
            .padding(.top,100)
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.white)
                    .frame(width: 248, height: 248)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timerSettings.timeRemaining) / CGFloat(timerSettings.focusTime * 60))
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 1))
                    .frame(width: 248, height: 248)
                VStack {
                    Text(timerSettings.timeString(timerSettings.timeRemaining))
                        .font(.system(size: 44))
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
            HStack(spacing: 60){
                if timerSettings.isRunning {
                    Button(action: {
                        timerSettings.isPaused.toggle()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 154)
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 56,height: 56)
                            Image(timerSettings.isPaused ? "Union" : "Vector2")
                        }
                    })
                    
                    Button(action: {
                        timerSettings.resetTimer()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 154)
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 56,height: 56)
                            Image("stop")
                        }
                    })
                } else {
                    Button(action: {
                        timerSettings.startTimer()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 154)
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 56,height: 56)
                            Image("Union")
                        }
                    })
                }
            }
            Spacer()
        }
        .sheet(isPresented: $showingFocusCategorySheet, content: {
            FocusCategoryBottomSheet(selectedCategory: $selectedCategory, showingFocusCategorySheet: $showingFocusCategorySheet)
                })
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if timerSettings.isRunning && !timerSettings.isPaused {
                if timerSettings.timeRemaining > 0 {
                    timerSettings.timeRemaining -= 1
                } else {
                    if timerSettings.focusTime > 0 {
                        timerSettings.timeRemaining = timerSettings.breakTime * 60 // convert to seconds
                        timerSettings.focusTime = 0
                    } else {
                        timerSettings.isRunning.toggle()
                        timerSettings.resetTimer()
                    }
                }
            }
        }
        .background{
            if let category = selectedCategory {
                Image("\(category)Background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            } else {
                Image("WorkoutBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
    }
}


struct FocusCategoryBottomSheet: View {
    @Binding var selectedCategory: String?
    @Binding var showingFocusCategorySheet: Bool
    let categories = ["Work", "Study", "Workout", "Reading","Meditation", "Others"]

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Spacer()
                Text("Focus Category")
                    .font(.headline)
                Spacer()
                Button(action: {
                    showingFocusCategorySheet = false
                }, label: {
                    Image("Vector 1")
                })
            }
            .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170, maximum: 200))], spacing: 25) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                            showingFocusCategorySheet = false
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius:16)
                                    .fill(selectedCategory == category ? Color.black : Color(red: 234/255, green: 234/255, blue: 234/255))
                                Text(category)
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedCategory == category ? Color.white : Color.black)
                                    .padding()
                                }
                        })
                    }
                }
                .background{
                    Color.white
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .presentationDetents([.height(350)])
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
