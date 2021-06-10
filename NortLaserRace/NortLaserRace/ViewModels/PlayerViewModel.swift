//
//  PlayerViewModel.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import SpriteKit

enum MovementDirection: Int {
    case movementUp = 0
    case movementDown = 2
    case movementRight = 1
    case movementLeft = 3
    case max = 4
}

class PlayerViewModel {
    private var moveAction: SKAction?
    private let moveActionKey: String = "moveActionKey"
    private var pView: PlayerView?
    private var pModel: PlayerModel?
    private var speed: Double = 300
    private var direction: MovementDirection = .movementRight
    private let lineMargin: CGFloat = 2.0
    var lineManager: LimitedPathRenderer
    var canMove: Bool = false
    init(_ playerModel: PlayerModel, _ playerView: PlayerView, _ direction: MovementDirection, color: SKColor,
         physicsContact: UInt32, physicsCategory: UInt32) {
        self.pView = playerView
        self.pModel = playerModel
        var player = 0
        if color == .red {
            player = 1
        }
        self.lineManager = LimitedPathRenderer(physicsCategory: physicsCategory,
                                               physicsContact: physicsContact,
                                               player: player)
        self.lineManager.addPoint(point: getPosition())
        self.lineManager.setColor(lineColor: color)
        setDirection(direction)
        moveAction = SKAction.move(by: directionToVector(self.direction), duration: 1.0 / speed)
        moveAction = SKAction.repeatForever(moveAction!)
    }
    func update(scene: SKScene) {
        self.lineManager.addPoint(point: getPosition())
        self.lineManager.update(scene: scene)
    }
    func setDirection(_ direction: MovementDirection) {
        self.direction = direction
    }
    func getDirection() -> MovementDirection {
        return self.direction
    }
    func setPosition(_ newPosition: CGPoint) {
        self.pView?.sprite.removeAction(forKey: moveActionKey)
        self.pView?.updatePosition(newPosition)
    }
    func getPosition() -> CGPoint {
        return (self.pView?.getPosition())!
    }
    func setSpeed(_ speed: Double) {
        self.speed = speed
    }
    func movePlayer() {
        if canMove {
            let node = self.pView?.sprite
            node?.run(moveAction!, withKey: moveActionKey)
        }
    }
    func rotatePlayer(_ direction: MovementDirection) {
        if canMove {
            setDirection(direction)
            self.pView?.sprite.removeAction(forKey: moveActionKey)
            self.moveAction = SKAction.move(by: directionToVector(self.direction), duration: 1.0 / speed)
            self.moveAction = SKAction.repeatForever(moveAction!)
            self.movePlayer()
            self.lineManager.addPoint(point: getPosition())
        }
    }
    func setActionDirection(_ direction: MovementDirection) {
        setDirection(direction)
        self.pView?.sprite.removeAction(forKey: moveActionKey)
        self.moveAction = SKAction.move(by: directionToVector(self.direction), duration: 1.0 / speed)
        self.moveAction = SKAction.repeatForever(moveAction!)
    }
    func pause() {
        self.pView?.sprite.isPaused = true
    }
    func resume() {
        self.pView?.sprite.isPaused = false
    }
    func isPaused() -> Bool {
        return self.pView!.sprite.isPaused
    }
    func dead() {
        self.resume()
        self.pView?.sprite.removeAction(forKey: moveActionKey)
        self.pView!.hide()
        canMove = false
    }
    func reset(_ position: CGPoint) {
        setPosition(position)
        self.pView?.sprite.isPaused = false
        self.pView?.show()
    }
    func getScore() -> Int {
        return self.pModel?.score ?? 0
    }
    func addScore(score: Int) {
        guard let model = self.pModel else {return}
        model.score += score
        if model.score <= 0 {
            model.score = 0
        }
    }
    func resetScore() {
        pModel?.score = 0
    }
    func loseLife() {
        guard let model = self.pModel else {return}
        model.lives -= 1
    }
    func isDead() -> Bool {
        guard let model = self.pModel else { return false }
        return model.lives <= 0
    }
    func getName() -> String {
        return pModel?.name ?? "Unnamed"
    }
    private func directionToVector(_ direction: MovementDirection) -> CGVector {
        switch direction {
        case .movementUp:
            return CGVector(dx: 0, dy: +1)
        case .movementDown:
            return CGVector(dx: 0, dy: -1)
        case .movementLeft:
            return CGVector(dx: -1, dy: 0)
        case .movementRight:
            return CGVector(dx: +1, dy: 0)
        case .max:
            return CGVector(dx: 0, dy: 0)
        }
    }

}
