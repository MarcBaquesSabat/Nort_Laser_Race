//
//  PlayerView.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import UIKit
import SpriteKit

class PlayerView {
    var sprite: SKSpriteNode
    init(_ name: String, _ playerSpriteName: String, _ parent: SKNode, _ position: CGPoint) {
        self.sprite = SKSpriteNode(imageNamed: playerSpriteName)
        self.sprite.name = name
        self.sprite.position = position
        self.sprite.size = CGSize(width: 75, height: 75)
        createPhysicsBody(sprite)
        parent.addChild(sprite)
    }
    func getPosition() -> CGPoint {
        return sprite.position
    }
    func createPhysicsBody(_ sprite: SKSpriteNode) {
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody!.affectedByGravity = false
        sprite.physicsBody!.allowsRotation = false
        sprite.physicsBody!.categoryBitMask = CollisionManager.getPlayerCategory()
        sprite.physicsBody!.collisionBitMask = CollisionManager.getNullMask()
        sprite.physicsBody!.contactTestBitMask = CollisionManager.getPlayerContact()
    }
    func updatePosition(_ newPosition: CGPoint) {
        self.sprite.removeAllActions()
        self.sprite.run(SKAction.move(to: newPosition, duration: 1.0))
    }
    func hide() {
        sprite.isHidden = true
    }
    func show() {
        sprite.isHidden = false
    }
}
