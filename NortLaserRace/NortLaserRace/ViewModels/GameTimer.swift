//
//  GameTimer.swift
//  NortLaserRace
//
//  Created by Alumne on 16/5/21.
//

import Foundation

class GameTimer {
    private var cronoTime: Double = 0.0
    private var timer: Timer?
    private var timeRemaining: Double = 0.0
    private var functionToExecuteAtEnd: () -> Void
    init(_ time: Double, function: @escaping () -> Void) {
        self.cronoTime = time
        self.timeRemaining = self.cronoTime
        self.functionToExecuteAtEnd = function
    }
    func start(_ context: Any) {
        self.timeRemaining = self.cronoTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                      selector: #selector(secondElapsed), userInfo: nil, repeats: true)
    }
    func end() {
        timeRemaining = 0.0
        self.functionToExecuteAtEnd()
    }
    func getTimeRemaining() -> Double {
        return timeRemaining
    }
    func getCronoTime() -> Double {
        return cronoTime
    }
    @objc func secondElapsed() {
        timeRemaining -= 1.0
        if timeRemaining <= 0.0 {
            timer?.invalidate()
            timer = nil
            end()
        }
    }
}
