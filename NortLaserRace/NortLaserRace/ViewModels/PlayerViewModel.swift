//
//  PlayerViewModel.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import SpriteKit

class PlayerViewModel {
    var moveAction: SKAction?
    var pView: PlayerView?
    var pModel: PlayerModel?
    var speed: Double = 350
    var direction: CGVector = CGVector(dx: 1, dy: 0)
    init(_ playerModel: PlayerModel, _ playerView: PlayerView) {
        self.pView = playerView
        self.pModel = playerModel
        moveAction = SKAction.move(by: CGVector(dx: 1, dy: 0), duration: 1.0 / speed)
        moveAction = SKAction.repeatForever(moveAction!)
    }
    func setDirection(_ direction: CGVector) {
        self.direction = direction
    }
    func setPosition(_ newPosition: CGPoint) {
        self.pView?.updatePosition(newPosition)
    }
    func movePlayer() {
        let node = self.pView?.sprite
        node?.run(moveAction!)
    }
    func rotatePlayer(_ direction: CGVector) {
        setDirection(direction)
        self.moveAction = SKAction.move(by: self.direction, duration: 1.0 / speed)
        self.moveAction = SKAction.repeatForever(moveAction!)
        self.movePlayer()
    }
    func stop() {
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
        self.pView!.hide()
    }
}
