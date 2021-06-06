//
//  ShopScene.swift
//  NortLaserRace
//
//  Created by Alumne on 6/6/21.
//

import Foundation
import SpriteKit
enum Avatars: Int {
    case suspicious = 0
    case metroid = 1
    case tentacle = 2
}
class ShopScene: SKScene {
    var avatar01NameNode: SKLabelNode?
    var avatar02NameNode: SKLabelNode?
    var avatar03NameNode: SKLabelNode?
    override func didMove(to view: SKView) {
        self.avatar01NameNode = self.childNode(withName: "//MetroidLabel") as? SKLabelNode
        if GameViewController.iapManager.avatarUnlocked(skinID: Skin.metroid.rawValue) {
            self.avatar01NameNode!.text = "Equip"
        }
        self.avatar02NameNode = self.childNode(withName: "//SuspiciousLabel") as? SKLabelNode
        if GameViewController.iapManager.avatarUnlocked(skinID: Skin.suspicious.rawValue) {
            self.avatar02NameNode!.text = "Equip"
        }
        self.avatar03NameNode = self.childNode(withName: "//TentacleLabel") as? SKLabelNode
        if GameViewController.iapManager.avatarUnlocked(skinID: Skin.tentacle.rawValue) {
            self.avatar03NameNode!.text = "Equip"
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "BackButton" {
                guard let sceneToLoad = SKScene(fileNamed: "GarageScene") else { return }
                sceneToLoad.scaleMode = .aspectFit
                self.scene!.view!.presentScene(sceneToLoad, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
              }
            if touchedNode.name == "Metroid_Buy" {
              print("Buy Metroid")
                GameViewController.iapManager.buyNonConsumable(product: Skin.metroid.rawValue)
            }
            if touchedNode.name == "Suspicious_Buy" {
                print("Buy Suspicious")
                GameViewController.iapManager.buyNonConsumable(product: Skin.suspicious.rawValue)
            }
            if touchedNode.name == "Tentacle_Buy" {
                print("Buy Tentacle")
                GameViewController.iapManager.buyNonConsumable(product: Skin.tentacle.rawValue)
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
    }
}
