//
//  TimeSelectorView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct RemainingTimeView: View {
    @State private var remainingTime: TimeInterval
    let endTime: Date
    @State private var timer: Timer?
    @State private var timeString: String = ""
    @State private var color: Color = .black
    @State private var backgroundColor: Color = .gray.opacity(0.3)
    
    init(endTime: Date) {
        self.endTime = endTime
        _remainingTime = State(initialValue: endTime.timeIntervalSinceNow)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 27)
                    .foregroundColor(backgroundColor)
                    .cornerRadius(17)
                
                Rectangle()
                    .frame(width: geometry.size.width * progress(), height: 27)
                    .foregroundColor(color)
                    .cornerRadius(17)
                
                Text(timeString)
                    .font(.system(size: 15, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(height: 27)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        updateTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateTime()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTime() {
        remainingTime = endTime.timeIntervalSinceNow
        if remainingTime <= 0 {
            stopTimer()
            timeString = "0 gün 0 saat 0 dakika 0 saniye"
            color = .black
            backgroundColor = .gray.opacity(0.3) // Arka plan rengini sıfırla
            return
        }
        
        let days = Int(remainingTime / (60 * 60 * 24))
        let hours = Int((remainingTime.truncatingRemainder(dividingBy: 60 * 60 * 24)) / (60 * 60))
        let minutes = Int((remainingTime.truncatingRemainder(dividingBy: 60 * 60)) / 60)
        let seconds = Int(remainingTime.truncatingRemainder(dividingBy: 60))
        
        // Daha okunabilir format
        if days > 0 {
            timeString = String(format: "%d gün %d saat %d dakika", days, hours, minutes)
        } else if hours > 0 {
            timeString = String(format: "%d saat %d dakika %d saniye", hours, minutes, seconds)
        } else if minutes > 0 {
            timeString = String(format: "%d dakika %d saniye", minutes, seconds)
        } else {
            timeString = String(format: "%d saniye", seconds)
        }
        
        // Calculate color gradient (green to red)
        let totalTime = endTime.timeIntervalSinceNow
        let timePassed = totalTime - remainingTime
        let percentage = timePassed / totalTime
        let clampedPercentage = min(max(percentage, 0), 1)
        color = Color(hue: 0.33 * (1 - clampedPercentage), saturation: 1, brightness: 1)
        
        // Arka plan rengini güncelle
        backgroundColor = Color(hue: 0.33 * clampedPercentage, saturation: 0.5, brightness: 0.9) // Açık yeşilden açık kırmızıya
        backgroundColor = .black
    }
    
    func progress() -> CGFloat {
        if endTime.timeIntervalSinceNow <= 0 {
            return 0.0
        } else {
            let totalTime = endTime.timeIntervalSinceNow
            let remaining = remainingTime
            let percentage = (totalTime - remaining) / totalTime
            return CGFloat(min(max(percentage, 0), 1))
        }
    }
}

