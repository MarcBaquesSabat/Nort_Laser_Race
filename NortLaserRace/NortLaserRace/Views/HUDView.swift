//
//  HUDView.swift
//  NortLaserRace
//
//  Created by Alumne on 6/6/21.
//

import Foundation
import SpriteKit

class HUDView {
    let scene: SKScene
    let playerModel: PlayerModel
    let IAModel: PlayerModel
    var playerLifesNodes: [SKSpriteNode] = []
    var IALifesNodes: [SKSpriteNode] = []
    let playerScoreLabel: SKLabelNode
    let IAScoreLabel: SKLabelNode
    init(scene: SKScene, playerModel: PlayerModel, IAModel: PlayerModel) {
        self.scene = scene
        self.playerModel = playerModel
        self.IAModel = IAModel
        // Players Life
        self.playerLifesNodes.append(((self.scene.childNode(withName: "//P1Live1")!) as? SKSpriteNode)!)
        self.playerLifesNodes.append(((self.scene.childNode(withName: "//P1Live2")!) as? SKSpriteNode)!)
        self.playerLifesNodes.append(((self.scene.childNode(withName: "//P1Live3")!) as? SKSpriteNode)!)
        // IA lifes
        self.IALifesNodes.append(((self.scene.childNode(withName: "//P2Live1")!) as? SKSpriteNode)!)
        self.IALifesNodes.append(((self.scene.childNode(withName: "//P2Live2")!) as? SKSpriteNode)!)
        self.IALifesNodes.append(((self.scene.childNode(withName: "//P2Live3")!) as? SKSpriteNode)!)
        // Score Label
        self.playerScoreLabel = (self.scene.childNode(withName: "//P1ScoreLabel") as? SKLabelNode)!
        self.IAScoreLabel = (self.scene.childNode(withName: "//P2ScoreLabel") as? SKLabelNode)!
        // Player label Name
        let playerNameLabel = self.scene.childNode(withName: "//P1UsernameLabel") as? SKLabelNode
        playerNameLabel!.text = playerModel.name
        // Player Avatar
    }
    func update() {
        self.playerScoreLabel.text = "\(self.playerModel.score)"
        self.IAScoreLabel.text = "\(self.IAModel.score)"
    }
    func updatePlayerHealthView() {
        for ind in playerModel.lives..<3 {
            self.playerLifesNodes[ind].texture = SKTexture(imageNamed: "lifeOff")
        }
    }
    func updateIAHealthView() {
        for ind in IAModel.lives..<3 {
            self.IALifesNodes[ind].texture = SKTexture(imageNamed: "lifeOff")
        }
    }
}
