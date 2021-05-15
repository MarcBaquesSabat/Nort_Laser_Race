//
//  PlayerModel.swift
//  NortLaserRace
//
//  Created by Alumne on 4/5/21.
//

import Foundation

class PlayerModel {
    var name: String = "Guest"
    var score: Int = 0
    var lives: Int = 3
    var avatar: Int = 0
    
    init() {
        
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
