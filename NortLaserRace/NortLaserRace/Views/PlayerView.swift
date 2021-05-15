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
        self.sprite?.size = CGSize(width: 75, height: 75)
        parent.addChild(self.sprite!)
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
