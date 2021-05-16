//
//  MatchManager.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import SpriteKit
import GameplayKit

enum ColisionEvent {
    case IABorder
    case playerBorder
    case IAKillPlayer
    case playerKillIA
}
enum MatchState {
    case toStart
    case waitingRound
    case round
    case end
}

class MatchManager {
    var player: PlayerViewModel?
    var IAPlayer: PlayerViewModel?
    var matchGameTimer: GameTimer?
    var preparationGameTimer: GameTimer?
    var matchTimmer: Timer?
    var timeLeft = 10.0
    var preparationTimmer: Timer?
    var preparationTime = 3.0
    var matchStarted: Bool = false
    var matchState: MatchState = .toStart
    init(_ scene: SKScene) {
        self.player = PlayerViewModel(PlayerModel(),
                                      PlayerView("Player_1", "Player01", scene, CGPoint(x: 400, y: 0)),
                                      MovementDirection.movementLeft)
        self.IAPlayer = PlayerViewModel(PlayerModel(),
                                        PlayerView("IA", "Player01", scene, CGPoint(x: -200, y: 0)),
                                        MovementDirection.movementRight)
        positionPlayers()
        matchGameTimer = GameTimer(180.0, function: endMatch)
        preparationGameTimer = GameTimer(3.0, function: startRound)
        let timmerLabel = scene.childNode(withName: "//TimmerLabel") as? SKLabelNode
        _ = TimmerView(matchGameTimer!, timmerLabel: timmerLabel!)
    }
    func isMatchStarted() -> Bool {
        return matchStarted
    }
    func startMatch() {
        matchGameTimer?.start(self)
        preparationGameTimer?.start(self)
        matchState = .waitingRound
        matchStarted = true
    }
    func startRound() {
        if matchState == .toStart || matchState == .waitingRound {
            print("Start round")
            player?.movePlayer()
            IAPlayer?.movePlayer()
            matchState = .round
        }
    }
    func endRound() {
        if matchState == .round {
            print("End round")
            matchState = .waitingRound
            positionPlayers()
            preparationGameTimer?.start(self)
        }
    }
    func endMatch() {
        if matchState != .end {
            matchState = .end
            positionPlayers()
            // Can be called when:
                // Timmer ends
                // Players with no life
            // Change scene with winner and scores
            print("End Match")
        }
    }
    func collisionDetected(colisionEvent: ColisionEvent) {
        guard let IAPlayer = self.IAPlayer, let player = self.player else {return}
        
        switch colisionEvent {
        case .IABorder:
            IAPlayer.addScore(score: -50)
            IAPlayer.loseLife()
            break
        case .playerBorder:
            player.addScore(score: -50)
            player.loseLife()
            break
        case .IAKillPlayer:
            IAPlayer.addScore(score: 100)
            player.loseLife()
            break
        case .playerKillIA:
            player.addScore(score: 100)
            IAPlayer.loseLife()
            break
        }
        if player.isDead() || IAPlayer.isDead() {
            endMatch()
            return
        }
        endRound()
    }
    private func positionPlayers() {
        player?.setPosition(CGPoint(x: 400, y: 0))
        IAPlayer?.setPosition(CGPoint(x: -200, y: 0))
    }
    @objc func matchSecondElapsed() {
        timeLeft -= 1
        if timeLeft <= 0 {
            matchTimmer?.invalidate()
            matchTimmer = nil
            endMatch()
        }
    }
    @objc func preparationSecondElapsed() {
        preparationTime -= 1
        if preparationTime <= 0 {
            preparationTimmer?.invalidate()
            preparationTimmer = nil
            startRound()
        }
    }
}
