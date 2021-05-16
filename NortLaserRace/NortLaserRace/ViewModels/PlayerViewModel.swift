//
//  PlayerViewModel.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import SpriteKit

enum MovementDirection {
    case movementUp
    case movementDown
    case movementRight
    case movementLeft
}

class PlayerViewModel {

    var moveAction: SKAction?
    let moveActionKey: String = "moveActionKey"
    var pView: PlayerView?
    var pModel: PlayerModel?
    var speed: Double = 200
    var direction: MovementDirection = .movementRight
    init(_ playerModel: PlayerModel, _ playerView: PlayerView, _ direction: MovementDirection) {
        self.pView = playerView
        self.pModel = playerModel
        setDirection(direction)
        moveAction = SKAction.move(by: directionToVector(self.direction), duration: 1.0 / speed)
        moveAction = SKAction.repeatForever(moveAction!)
    }
    func setDirection(_ direction: MovementDirection) {
        self.direction = direction
    }
    func setPosition(_ newPosition: CGPoint) {
        self.pView?.sprite?.removeAction(forKey: moveActionKey)
        self.pView?.updatePosition(newPosition)
    }
    func setSpeed(_ speed: Double) {
        self.speed = speed
    }
    func movePlayer() {
        let node = self.pView?.sprite
        node?.run(moveAction!, withKey: moveActionKey)
    }
    func rotatePlayer(_ direction: MovementDirection) {
        setDirection(direction)
        self.pView?.sprite?.removeAction(forKey: moveActionKey)
        self.moveAction = SKAction.move(by: directionToVector(self.direction), duration: 1.0 / speed)
        self.moveAction = SKAction.repeatForever(moveAction!)
        self.movePlayer()
    }
    func pause() {
        self.pView?.sprite?.isPaused = true
    }
    func resume() {
        self.pView?.sprite?.isPaused = false
    }
    func isPaused() -> Bool {
        return self.pView!.sprite!.isPaused
    }
    func dead() {
        self.resume()
        self.pView?.sprite?.removeAction(forKey: moveActionKey)
        self.pView!.hide()
    }
    func reset(_ position: CGPoint) {
        setPosition(position)
        self.pView?.sprite?.isPaused = false
        self.pView?.show()
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
        }
    }

}
