//
//  LineRenderer.swift
//  NortLaserRace
//
//  Created by Alumne on 22/5/21.
//

import Foundation
import SpriteKit
import GameplayKit

class LimitedPathRenderer {
    private let maxDistance: CGFloat = 700.0
    private let distMargen: CGFloat = 2.0
    private let lineWidth: CGFloat = 7
    private let lineGlow: CGFloat = 12
    private var points = [CGPoint]()
    private var lineColor: SKColor = .white
    private var linearShapeNode: SKShapeNode?
    private var physicsCategory: UInt32 = 0
    private var physicsContact: UInt32 = 0
    private var draw: Bool = false
    private var player = 0
    init(physicsCategory: UInt32, physicsContact: UInt32, player: Int) {
        linearShapeNode = SKShapeNode(points: &self.points, count: points.count)
        self.player = player
    }
    init(points: [CGPoint], physicsCategory: UInt32, physicsContact: UInt32) {
        self.points = points
        linearShapeNode = SKShapeNode(points: &self.points, count: points.count)
        self.physicsCategory = physicsCategory
        self.physicsContact = physicsContact
    }
    func reset() {
        self.stop()
        points.removeAll()
        self.linearShapeNode!.removeFromParent()
    }
    func stop() {
        draw = false
    }
    func start() {
        draw = true
    }
    func setColor(lineColor: SKColor) {
        self.lineColor = lineColor
    }
    func addPoint(point: CGPoint) {
        guard draw == true else {return}
        self.points.insert(point, at: 0)
    }
    func update(scene: SKScene) {
        guard draw == true else {return}
        guard points.count > 2 else { return }
        var distance: CGFloat = 0.0
        for index in 0..<points.count - 1 {
            distance += points[index].distanceTo(points[index + 1])
        }
        if distance > maxDistance {
            shortenLines(distanceToShorten: distance - maxDistance)
        }
        draw(scene: scene)
    }
    private func draw(scene: SKScene) {
        if self.linearShapeNode == nil {
            return
        }
        // Draw Lines
        self.linearShapeNode!.removeFromParent()
        self.linearShapeNode! = SKShapeNode(points: &self.points, count: points.count)
        self.linearShapeNode!.name = "Border_Line"
        self.linearShapeNode!.lineWidth = self.lineWidth
        self.linearShapeNode!.glowWidth = self.lineGlow
        self.linearShapeNode!.strokeColor = self.lineColor
        self.linearShapeNode!.physicsBody = SKPhysicsBody(edgeChainFrom: self.linearShapeNode!.path!)
        self.linearShapeNode!.physicsBody?.affectedByGravity = false
        if player == 0 {
            self.linearShapeNode!.physicsBody?.categoryBitMask = CollisionManager.getPlayerCategory()
            self.linearShapeNode!.physicsBody?.collisionBitMask = CollisionManager.getNullMask()
            self.linearShapeNode!.physicsBody?.contactTestBitMask = CollisionManager.getPlayerContact()
        } else {
            self.linearShapeNode!.physicsBody?.categoryBitMask = CollisionManager.getIACategory()
            self.linearShapeNode!.physicsBody?.collisionBitMask = CollisionManager.getNullMask()
            self.linearShapeNode!.physicsBody?.contactTestBitMask = CollisionManager.getIAContact()
        }
        scene.addChild(self.linearShapeNode!)
    }
    private func shortenLines(distanceToShorten: CGFloat) {
        // Move last point distanceToShorten
        guard points.count > 1 else {
            return
        }
        let actualLastDistance = points[points.count - 1].distanceTo(points[points.count - 2])
        if actualLastDistance == 0 {
            points.removeLast()
            shortenLines(distanceToShorten: distanceToShorten)
            return
        }
        if actualLastDistance > distanceToShorten {
            points[points.count - 1] = points[points.count - 1].moveTowards(points[points.count - 2], distanceToShorten)

        } else {
            points[points.count - 1] = points[points.count - 1].moveTowards(points[points.count - 2],
                                                                            actualLastDistance)
            points.removeLast()
            shortenLines(distanceToShorten: distanceToShorten - actualLastDistance)
            return
        }
    }
}
