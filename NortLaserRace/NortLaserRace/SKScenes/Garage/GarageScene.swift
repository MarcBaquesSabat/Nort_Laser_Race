//
//  GameScene.swift
//  NortLaserRace
//
//  Created by Alumne on 29/4/21.
// swiftlint:disable line_length

import SpriteKit
import GameplayKit

class GarageScene: SKScene {

    override func didMove(to view: SKView) {
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "HellModeButton" {
                self.scene!.view!.presentScene(SKScene(fileNamed: "GameScene")!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
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
        print("Garage Scene")
    }
}
