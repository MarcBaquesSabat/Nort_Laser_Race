//
//  PlayerMovement.swift
//  NortLaserRace
//
//  Created by Alumne on 20/5/21.
//

import Foundation

protocol MovementBehaviour {
    func startMoving()
    func stopMoving()
    func turnDirection()
    func setPosition()
}
