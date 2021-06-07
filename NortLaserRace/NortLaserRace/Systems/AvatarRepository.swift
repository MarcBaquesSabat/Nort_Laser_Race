//
//  AvatarRepository.swift
//  NortLaserRace
//
//  Created by Alumne on 7/6/21.
//

import Foundation
import SpriteKit

class AvatarRepository {
    static func getAvatarTexture(skinID: Int) -> SKTexture {
        switch skinID {
        case Avatars.defaultAvatar.rawValue:
            return SKTexture(imageNamed: "deafultPlayerIcon")
        case Avatars.suspicious.rawValue:
            return SKTexture(imageNamed: "suspiciousPlayerIcon")
        case Avatars.metroid.rawValue:
            return SKTexture(imageNamed: "metroidPlayerIcon")
        case Avatars.tentacle.rawValue:
            return SKTexture(imageNamed: "tentaclePlayerIcon")
        default:
            return SKTexture(imageNamed: "defaultPlayerIcon")
        }
    }
}
