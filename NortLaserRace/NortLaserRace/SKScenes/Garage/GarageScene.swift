//
//  GameScene.swift
//  NortLaserRace
//
//  Created by Alumne on 29/4/21.
// swiftlint:disable line_length

import SpriteKit
import GameplayKit

class GarageScene: SKScene {
    let userDefaults: UserDefaults = UserDefaults.standard
    override func didMove(to view: SKView) {
        let parent = self.childNode(withName: "//Bg") as? SKSpriteNode
        let bgParticles1 = SKEmitterNode(fileNamed: "LaserLines")
        bgParticles1?.position = CGPoint(x: 0, y: 550)
        bgParticles1?.advanceSimulationTime(10)
        parent?.addChild(bgParticles1!)
        let bgParticles2 = SKEmitterNode(fileNamed: "LaserLines")
        bgParticles2?.position = CGPoint(x: -200, y: 550)
        bgParticles2?.zRotation = CGFloat(0.436)
        bgParticles2?.advanceSimulationTime(10)
        parent?.addChild(bgParticles2!)
        let haveScore = userDefaults.object(forKey: SaveManager.getPlayerScoreKey())
        if haveScore == nil {
            print("No score saved")
        } else {
            if let score = haveScore as? Int {
                print("Score as int: \(score)")
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "HellModeButton" {
                guard let sceneToLoad = SKScene(fileNamed: "GameScene") else { return }
                sceneToLoad.scaleMode = .aspectFit
                self.scene!.view!.presentScene(sceneToLoad, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
              }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func update(_ currentTime: TimeInterval) {
    }
}
