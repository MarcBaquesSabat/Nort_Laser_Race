//
//  IAViewModel.swift
//  NortLaserRace
//
//  Created by Alumne on 8/6/21.
//

import Foundation
import SpriteKit

class IAViewModel {
    private var moveAction: SKAction?
    private let moveActionKey: String = "moveActionKey"
    private var pView: IAView?
    private var pModel: PlayerModel?
    private var speed: Double = 300
    private var direction: MovementDirection = .movementRight
    private let lineMargin: CGFloat = 2.0
    var lineManager: LimitedPathRenderer
    var canMove: Bool = false
    var updating: Bool = true
    init(_ playerModel: PlayerModel, _ playerView: IAView, _ direction: MovementDirection, color: SKColor,
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
        self.pView!.setDetectorDirection(direction: self.direction)
    }
    func update(scene: SKScene) {
        self.lineManager.addPoint(point: getPosition())
        self.lineManager.update(scene: scene)
    }
    func updateDecision(playerDirection: MovementDirection) {
        print("I have to react")
        self.updating = false
        pView!.detectionSprite.run(SKAction.wait(forDuration: 1.0), completion: {
            self.updating = true
        })
        var nextDirection: MovementDirection
        if Bool.random() {
            let nonMod = self.direction.rawValue - 1
            let max = nonMod %% MovementDirection.max.rawValue
            nextDirection = MovementDirection(rawValue: max)!
        } else {
            let nonMod = self.direction.rawValue + 1
            let max = nonMod %% MovementDirection.max.rawValue
            nextDirection = MovementDirection(rawValue: max)!
        }
        print("Actual: \(self.direction) Next: \(nextDirection)")
        self.rotatePlayer(nextDirection)
    }
    func setDirection(_ direction: MovementDirection) {
        self.direction = direction
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
            self.pView!.setDetectorDirection(direction: direction)
        }
    }
    func setActionDirection(_ direction: MovementDirection) {
        setDirection(direction)
        self.pView?.sprite.removeAction(forKey: moveActionKey)
        self.moveAction = SKAction.move(by: directionToVector(self.direction), duration: 1.0 / speed)
        self.moveAction = SKAction.repeatForever(moveAction!)
        self.pView!.setDetectorDirection(direction: direction)
    }
    func disableColision() {
        updating = false
    }
    func enableColision() {
        updating = true
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

infix operator %%
extension Int {
    static  func %% (_ left: Int, _ right: Int) -> Int {
        if left >= 0 { return left % right }
        if left >= -right { return (left+right) }
        return ((left % right)+right)%right
    }
}
