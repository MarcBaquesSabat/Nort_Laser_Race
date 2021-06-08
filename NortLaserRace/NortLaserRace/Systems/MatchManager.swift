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
    let matchTime = 15.0
    // Players
    var player: PlayerViewModel?
    var IAPlayer: IAViewModel?
    // Timmers
    var matchGameTimer: GameTimer?
    var preparationGameTimer: GameTimer?
    var matchTimmerView: TimmerView?
    // Others nodes
    var startLabel: SKLabelNode?
    var endHandlerNode: SKNode
    // State
    var matchState: MatchState = .toStart
    var standard: UserDefaults = UserDefaults.standard
    // Scene context
    let scene: SKScene?
    // HUD view
    let hudView: HUDView
    // INIT
    init(_ scene: SKScene) {
        self.scene = scene
        self.endHandlerNode = scene.childNode(withName: "//EndHandler")!
        self.endHandlerNode.isHidden = true
        let playerModel = PlayerModel()
        let iaModel = PlayerModel()
        self.player = PlayerViewModel(playerModel,
                                      PlayerView("Player_1", "bluePlayer", scene, CGPoint(x: 400, y: 0)),
                                      MovementDirection.movementLeft,
                                      color: .blue,
                                      physicsContact: CollisionManager.getPlayerContact(),
                                      physicsCategory: CollisionManager.getPlayerCategory())
        self.IAPlayer = IAViewModel(iaModel,
                                        IAView("IA", "redPlayer", scene, CGPoint(x: -200, y: 0)),
                                        MovementDirection.movementRight,
                                        color: .red,
                                        physicsContact: CollisionManager.getIAContact(),
                                        physicsCategory: CollisionManager.getIACategory())
        self.hudView = HUDView(scene: scene, playerModel: playerModel, IAModel: iaModel)
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
        self.hudView.update()
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
            player?.lineManager.reset()
            IAPlayer?.lineManager.reset()
            positionPlayers()
            matchGameTimer?.end()
            setWinnerEnding()
        }
    }
    func collisionDetected(colisionEvent: ColisionEvent) {
        guard let IAPlayer = self.IAPlayer, let player = self.player else {return}
        if matchState == .round {
            switch colisionEvent {
            case .IABorder:
                IAPlayer.addScore(score: -50)
                player.addScore(score: 25)
                IAPlayer.loseLife()
                self.hudView.updateIAHealthView()
            case .playerBorder:
                player.addScore(score: -50)
                IAPlayer.addScore(score: 25)
                player.loseLife()
                self.hudView.updatePlayerHealthView()
            case .IAKillPlayer:
                IAPlayer.addScore(score: 100)
                player.loseLife()
                self.hudView.updatePlayerHealthView()
            case .playerKillIA:
                player.addScore(score: 100)
                IAPlayer.loseLife()
                self.hudView.updateIAHealthView()
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
    private func setWinnerEnding() {
        self.endHandlerNode.isHidden = false
        let pointsP1 = player!.getScore()
        let pointsIA = IAPlayer!.getScore()
        let winnerLabelNode = self.scene?.childNode(withName: "//WinnerLabel")! as? SKLabelNode
        let scoreLabelNode = self.scene?.childNode(withName: "//ScoreLabel")! as? SKLabelNode
        print("Points p1: \(pointsP1)")
        print("Points IA: \(pointsIA)")
        if pointsIA > pointsP1 {
            winnerLabelNode?.text = "IA Wins"
            scoreLabelNode?.text = "\(pointsIA)"
        } else if pointsIA == pointsP1 {
            winnerLabelNode?.text = "Draw"
            scoreLabelNode?.text = "\(pointsP1)/\(pointsIA)"
        } else {
            winnerLabelNode?.text = "\(self.player!.getName()) wins"
            scoreLabelNode?.text = "\(pointsP1)"
        }
        standard.setValue(pointsP1, forKey: SaveManager.getPlayerScoreKey())
    }
}
