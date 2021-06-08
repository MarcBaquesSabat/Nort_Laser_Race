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
    // 0x0000_0100 - IA
    // 0x0000_1000 - Detector
    // Contact
    // 0x0000-0110 - Player
    // 0x0000_0101 - Borders
    // 0x0000_0011 - IA
    // 0x0000_0011 - Detector
    static func getNullMask() -> UInt32 {
        return 0x0000_0000
    }
    static func getPlayerCategory() -> UInt32 {
        return 0x0000_0001
    }
    static func getObstacleCategory() -> UInt32 {
        return 0x0000_0010
    }
    static func getIACategory() -> UInt32 {
        return 0x0000_0100
    }
    static func getDetectorCategory() -> UInt32 {
        return 0x0000_1000
    }
    static func getPlayerContact() -> UInt32 {
        return 0x0000_0110
    }
    static func getIAContact() -> UInt32 {
        return 0x0000_0011
    }
    static func getObstacleContact() -> UInt32 {
        return 0x0000_0101
    }
    static func getDetectorContact() -> UInt32 {
        return 0x0000_0011
    }
}
