//
//  GameScenePhysicsExtension.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("Colision")
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }

        let oneNodeIsPlayer = nameA.hasPrefix("Player") || nameB.hasPrefix("Player")
        let oneNodeIsIA = nameA.hasPrefix("IA") || nameB.hasPrefix("IA")
        let oneNodeIsBorder = nameA.hasPrefix("Border") || nameB.hasPrefix("Border")
        let oneNodeIsDetector = nameA.hasPrefix("Detector") || nameB.hasPrefix("Detector")
        if oneNodeIsDetector, oneNodeIsPlayer {
            print("Detector - Player")
            matchManager?.collisionDetected(colisionEvent: .IADetection)
            return
        }
        if oneNodeIsDetector, oneNodeIsBorder {
            print("Detector - Border")
            matchManager?.collisionDetected(colisionEvent: .IADetection)
            return
        }
        if oneNodeIsPlayer, oneNodeIsBorder {
            print("Player - Border")
            matchManager?.collisionDetected(colisionEvent: .playerBorder)
            return
        }
        if oneNodeIsIA, oneNodeIsBorder {
            print("IA - Border")
            matchManager?.collisionDetected(colisionEvent: .IABorder)
            return
        }

        if oneNodeIsIA, oneNodeIsPlayer {
            print("Players - IA")
            matchManager?.collisionDetected(colisionEvent: .playerKillIA)
            return
        }
    }
}
