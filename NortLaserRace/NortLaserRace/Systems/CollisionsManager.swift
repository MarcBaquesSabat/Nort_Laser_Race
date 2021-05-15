//
//  CollisionsManager.swift
//  NortLaserRace
//
//  Created by Alumne on 15/5/21.
//

import Foundation

class CollisionManager {
    // Categories
    // 0x0000-0001 - Player
    // 0x0000_0010 - Borders
    static func getNullMask() -> UInt32 {
        return 0x0000_0000
    }
    static func getPlayerCategory() -> UInt32 {
        return 0x0000_0001
    }
    static func getPlayerContact() -> UInt32 {
        return 0x0000_0011
    }
    static func getObstacleCategory() -> UInt32 {
        return 0x0000_0010
    }
    static func getObstacleContact() -> UInt32 {
        return 0x0000_0001
    }
}
