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
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var sprite: SKSpriteNode?
    init(_ name: String, _ playerSpriteName: String, _ parent: SKNode ) {
        self.sprite = SKSpriteNode(imageNamed: playerSpriteName)
        self.sprite?.name = name
        guard let sprite = self.sprite else { return }
        sprite.size = CGSize(width: 75, height: 75)
        createPhysicsBody(sprite)
        parent.addChild(sprite)
    }
    func createPhysicsBody(_ sprite: SKSpriteNode) {
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        guard let spritePhysicBody = sprite.physicsBody else { return }
        spritePhysicBody.affectedByGravity = false
        spritePhysicBody.allowsRotation = false
        spritePhysicBody.categoryBitMask = CollisionManager.getPlayerCategory()
        spritePhysicBody.collisionBitMask = CollisionManager.getNullMask()
        spritePhysicBody.contactTestBitMask = CollisionManager.getPlayerContact()
    }
    func updatePosition(_ newPosition: CGPoint) {
        guard sprite != nil else { return }
        sprite?.position = newPosition
    }
    func hide() {
        sprite?.isHidden = true
    }
    func show() {
        sprite?.isHidden = false
    }
}
