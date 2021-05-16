//
//  TimmerView.swift
//  NortLaserRace
//
//  Created by Alumne on 16/5/21.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class TimmerView {
    var gameTimer: GameTimer?
    init(_ gameTimer: GameTimer, timmerLabel: SKLabelNode) {
        self.gameTimer = gameTimer
        timmerLabel.text = String(format: "%.0f", gameTimer.getCronoTime())
    }
}
