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
    // Configuration
    let preparationTime = 3.0
    let matchTime = 5.0
    // Players
    var player: PlayerViewModel?
    var IAPlayer: PlayerViewModel?
    // Timmers
    var matchGameTimer: GameTimer?
    var preparationGameTimer: GameTimer?
    var matchTimmerView: TimmerView?
    // Others nodes
    var startLabel: SKLabelNode?
    // State
    var matchState: MatchState = .toStart
    // INIT
    init(_ scene: SKScene) {
        self.player = PlayerViewModel(PlayerModel(),
                                      PlayerView("Player_1", "bluePlayer", scene, CGPoint(x: 400, y: 0)),
                                      MovementDirection.movementLeft,
                                      color: .blue,
                                      physicsContact: CollisionManager.getPlayerContact(),
                                      physicsCategory: CollisionManager.getPlayerCategory())
        self.IAPlayer = PlayerViewModel(PlayerModel(),
                                        PlayerView("IA", "redPlayer", scene, CGPoint(x: -200, y: 0)),
                                        MovementDirection.movementRight,
                                        color: .red,
                                        physicsContact: CollisionManager.getIAContact(),
                                        physicsCategory: CollisionManager.getIACategory())
        positionPlayers()
        matchGameTimer = GameTimer(matchTime, function: endMatch)
        preparationGameTimer = GameTimer(preparationTime, function: startRound)
        let timmerLabel = scene.childNode(withName: "//TimmerLabel") as? SKLabelNode
        if timmerLabel != nil {
            self.matchTimmerView = TimmerView(matchGameTimer!, timmerLabel: timmerLabel!)
        }
        self.startLabel = scene.childNode(withName: "//StartLabel") as? SKLabelNode
    }
    func update(scene: SKScene) {
        self.matchTimmerView?.update()
        player?.update(scene: scene)
        IAPlayer?.update(scene: scene)
    }
    func isMatchStarted() -> Bool {
        return matchState != .toStart
    }
    func startMatch() {
        matchGameTimer?.start()
        preparationGameTimer?.start()
        self.startLabel?.isHidden = true
        matchState = .waitingRound
    }
    func startRound() {
        if matchState == .toStart || matchState == .waitingRound {
            print("Start round")
            player?.canMove = true
            player?.lineManager.start()
            player?.movePlayer()
            IAPlayer?.canMove = true
            IAPlayer?.movePlayer()
            IAPlayer?.lineManager.start()
            matchState = .round
        }
    }
    func endRound() {
        if matchState == .round {
            print("End round")
            matchState = .waitingRound
            positionPlayers()
            IAPlayer?.lineManager.reset()
            IAPlayer?.canMove = false
            player?.canMove = false
            player?.lineManager.reset()
            preparationGameTimer?.start()
        }
    }
    func endMatch() {
        if matchState != .end {
            matchState = .end
            positionPlayers()
            matchGameTimer?.end()
            // Can be called when:
                // Timmer ends
                // Players with no life
            // Change scene with winner and scores
            print("End Match")
        }
    }
    func collisionDetected(colisionEvent: ColisionEvent) {
        guard let IAPlayer = self.IAPlayer, let player = self.player else {return}
        if matchState == .round {
            switch colisionEvent {
            case .IABorder:
                IAPlayer.addScore(score: -50)
                IAPlayer.loseLife()
            case .playerBorder:
                player.addScore(score: -50)
                player.loseLife()
            case .IAKillPlayer:
                IAPlayer.addScore(score: 100)
                player.loseLife()
            case .playerKillIA:
                player.addScore(score: 100)
                IAPlayer.loseLife()
            }
            if player.isDead() || IAPlayer.isDead() {
                endMatch()
                return
            }
            endRound()
        }
    }
    private func positionPlayers() {
        player?.setPosition(CGPoint(x: 400, y: 0))
        IAPlayer?.setPosition(CGPoint(x: -200, y: 0))
    }
}
