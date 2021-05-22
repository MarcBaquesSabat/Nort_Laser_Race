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
import SwiftUI

class TimmerView {
    @State var gameTimer: GameTimer
    var labelNode: SKLabelNode?
    init(_ gameTimer: GameTimer, timmerLabel: SKLabelNode) {
        self.gameTimer = gameTimer
        self.labelNode = timmerLabel
        timmerLabel.text = String(format: "%.0f", self.gameTimer.getCronoTime())
    }
    func update() {
        labelNode?.text = String(format: "%.0f", gameTimer.getTimeRemaining())
    }
}
