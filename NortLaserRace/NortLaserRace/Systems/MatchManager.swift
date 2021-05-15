//
//  MatchManager.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import SpriteKit
import GameplayKit

class MatchManager {
    var player: PlayerViewModel?
    var IAPlayer: PlayerViewModel?
    init(_ scene: SKScene) {
        self.player = PlayerViewModel(PlayerModel(), PlayerView("Player_1", "Player01", scene), MovementDirection.movementLeft)
        self.IAPlayer = PlayerViewModel(PlayerModel(), PlayerView("IA", "Player01", scene), MovementDirection.movementRight)
        player?.setPosition(CGPoint(x: 400, y: 0))
        IAPlayer?.setPosition(CGPoint(x: -200, y: 0))
    }
    func startMatch() {
        // Timmer to 3 minutes
        // Countdown 3 sec on tap
            // Players move
    }
    func startRound() {
        player?.movePlayer()
        IAPlayer?.movePlayer()
    }
    func endRound() {
        // Update scores
        // Players reposition
        // Countdown 3 sec on tap
            // Players move
    }
    func endMatch() {
        // Can be called when:
            // Timmer ends
            // Players with no life
        // Change scene with winner and scores
    }
}
