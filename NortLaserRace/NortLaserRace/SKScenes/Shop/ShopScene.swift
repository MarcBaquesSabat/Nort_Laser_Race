//
//  ShopScene.swift
//  NortLaserRace
//
//  Created by Alumne on 6/6/21.
//

import Foundation
import SpriteKit
enum Avatars: Int {
    case suspicious = 3
    case metroid = 1
    case tentacle = 2
    case defaultAvatar = 0
}
class ShopScene: SKScene {
    var avatar01NameNode: SKLabelNode?
    var avatar02NameNode: SKLabelNode?
    var avatar03NameNode: SKLabelNode?
    let userDefaults: UserDefaults = UserDefaults.standard
    override func didMove(to view: SKView) {
        self.avatar01NameNode = self.childNode(withName: "//MetroidLabel") as? SKLabelNode
        if GameViewController.iapManager.avatarUnlocked(skinID: Skin.metroid.rawValue) {
            if userDefaults.integer(forKey: SaveManager.getActualSkinKey()) != Avatars.metroid.rawValue {
                self.avatar01NameNode!.text = "Equip"
            } else {
                self.avatar01NameNode!.text = "Equipped"
            }
        }
        self.avatar02NameNode = self.childNode(withName: "//SuspiciousLabel") as? SKLabelNode
        if GameViewController.iapManager.avatarUnlocked(skinID: Skin.suspicious.rawValue) {
            if userDefaults.integer(forKey: SaveManager.getActualSkinKey()) != Avatars.suspicious.rawValue {
                self.avatar02NameNode!.text = "Equip"
            } else {
                self.avatar02NameNode!.text = "Equipped"
            }
        }
        self.avatar03NameNode = self.childNode(withName: "//TentacleLabel") as? SKLabelNode
        if GameViewController.iapManager.avatarUnlocked(skinID: Skin.tentacle.rawValue) {
            if userDefaults.integer(forKey: SaveManager.getActualSkinKey()) != Avatars.tentacle.rawValue {
                self.avatar03NameNode!.text = "Equip"
            } else {
                self.avatar03NameNode!.text = "Equipped"
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
              let location = touch.location(in: self)
              let touchedNode = atPoint(location)
              if touchedNode.name == "BackButton" {
                guard let sceneToLoad = SKScene(fileNamed: "GarageScene") else { return }
                sceneToLoad.scaleMode = .aspectFit
                self.scene!.view!.presentScene(sceneToLoad,
                                               transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
              }
            if touchedNode.name == "Metroid_Buy" {
                if self.avatar01NameNode!.text == "Equip" {
                    userDefaults.setValue(Avatars.metroid.rawValue, forKey: SaveManager.getActualSkinKey())
                    GameViewController.user.avatar = Avatars.metroid.rawValue
                    unselectAllAvatars()
                    self.avatar01NameNode!.text = "Equipped"
                } else {
                    GameViewController.iapManager.buyNonConsumable(product: Skin.metroid.rawValue)
                    unselectAllAvatars()
                    userDefaults.setValue(Avatars.metroid.rawValue, forKey: SaveManager.getActualSkinKey())
                    GameViewController.user.avatar = Avatars.metroid.rawValue
                    self.avatar01NameNode!.text = "Equipped"
                }
            }
            if touchedNode.name == "Suspicious_Buy" {
                if self.avatar02NameNode!.text == "Equip" {
                    userDefaults.setValue(Avatars.suspicious.rawValue, forKey: SaveManager.getActualSkinKey())
                    GameViewController.user.avatar = Avatars.suspicious.rawValue
                    unselectAllAvatars()
                    self.avatar02NameNode!.text = "Equipped"
                } else {
                    GameViewController.iapManager.buyNonConsumable(product: Skin.suspicious.rawValue)
                    unselectAllAvatars()
                    userDefaults.setValue(Avatars.suspicious.rawValue, forKey: SaveManager.getActualSkinKey())
                    GameViewController.user.avatar = Avatars.suspicious.rawValue
                    self.avatar02NameNode!.text = "Equipped"
                }
            }
            if touchedNode.name == "Tentacle_Buy" {
                if self.avatar03NameNode!.text == "Equip" {
                    userDefaults.setValue(Avatars.tentacle.rawValue, forKey: SaveManager.getActualSkinKey())
                    GameViewController.user.avatar = Avatars.tentacle.rawValue
                    unselectAllAvatars()
                    self.avatar03NameNode!.text = "Equipped"
                } else {
                    GameViewController.iapManager.buyNonConsumable(product: Skin.tentacle.rawValue)
                    unselectAllAvatars()
                    userDefaults.setValue(Avatars.tentacle.rawValue, forKey: SaveManager.getActualSkinKey())
                    GameViewController.user.avatar = Avatars.tentacle.rawValue
                    self.avatar03NameNode!.text = "Equipped"
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
    }
    private func unselectAllAvatars() {
        if self.avatar01NameNode!.text == "Equipped"{
            self.avatar01NameNode!.text = "Equip"
        }
        if self.avatar02NameNode!.text == "Equipped"{
            self.avatar02NameNode!.text = "Equip"
        }
        if self.avatar03NameNode!.text == "Equipped"{
            self.avatar03NameNode!.text = "Equip"
        }
    }
}
