//
//  PlayerModel.swift
//  NortLaserRace
//
//  Created by Alumne on 4/5/21.
//

import Foundation

class Player {
    var name: String = "Unnamed"
    var score: Int = 0
    var lives: Int = 3
    var avatar: Int
    
    init(_ avatar: Int) {
        self.avatar = avatar
    }
}

class MovementController {
}
protocol InputBehaviour {
}
class UserInputBehaviour: InputBehaviour {
}
class IAInputBehaviour: InputBehaviour {
}
