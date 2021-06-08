//
//  IAView.swift
//  NortLaserRace
//
//  Created by Alumne on 8/6/21.
//

import Foundation
import UIKit
import SpriteKit

class IAView {
    var sprite: SKSpriteNode
    let detectionSprite: SKSpriteNode
    init(_ name: String, _ playerSpriteName: String, _ parent: SKNode, _ position: CGPoint) {
        self.sprite = SKSpriteNode(imageNamed: playerSpriteName)
        self.sprite.name = name
        self.sprite.position = position
        self.sprite.size = CGSize(width: 75, height: 75)
        self.detectionSprite = SKSpriteNode(color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0), size: CGSize(width: 100, height: 100))
        self.detectionSprite.name = "Detector"
        self.detectionSprite.physicsBody = SKPhysicsBody(rectangleOf: detectionSprite.size)
        self.detectionSprite.physicsBody!.affectedByGravity = false
        self.detectionSprite.physicsBody!.allowsRotation = false
        self.detectionSprite.physicsBody!.categoryBitMask = CollisionManager.getIACategory()
        self.detectionSprite.physicsBody!.collisionBitMask = CollisionManager.getNullMask()
        self.detectionSprite.physicsBody!.contactTestBitMask = CollisionManager.getIAContact()
        createPhysicsBody(sprite)
        parent.addChild(sprite)
        self.sprite.addChild(self.detectionSprite)
        let point = self.sprite.position.x + 300
        setDetectionPosition(newPosition: CGPoint(x: point, y: self.sprite.position.y))
    }
    func getPosition() -> CGPoint {
        return sprite.position
    }
    func createPhysicsBody(_ sprite: SKSpriteNode) {
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody!.affectedByGravity = false
        sprite.physicsBody!.allowsRotation = false
        sprite.physicsBody!.categoryBitMask = CollisionManager.getDetectorCategory()
        sprite.physicsBody!.collisionBitMask = CollisionManager.getNullMask()
        sprite.physicsBody!.contactTestBitMask = CollisionManager.getDetectorContact()
    }
    func disableCollision() {
        self.detectionSprite.isHidden = true
    }
    func updatePosition(_ newPosition: CGPoint) {
        self.sprite.removeAllActions()
        self.sprite.run(SKAction.move(to: newPosition, duration: 1.0))
    }
    func setDetectionPosition(newPosition: CGPoint) {
        self.detectionSprite.position = newPosition
    }
    func hide() {
        sprite.isHidden = true
    }
    func show() {
        sprite.isHidden = false
    }
}
