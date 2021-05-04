//
//  GameViewController.swift
//  NortLaserRace
//
//  Created by Alumne on 29/4/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? SKView?, view != nil {
            // Load the SKScene from 'GarageScene.sks'
            if let scene = SKScene(fileNamed: "GarageScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
                view!.presentScene(scene)
            }
            view!.ignoresSiblingOrder = true
            view!.showsFPS = true
            view!.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
