import SpriteKit
import GameplayKit
import Foundation
import SwiftUI

class GameScene: SKScene {
    var matchManager: MatchManager?
    var swipeableView: UIView?

    override func didMove(to view: SKView) {
        initializeSwipe()
        matchManager = MatchManager(self)
        initBorderPhysics("Border1")
        initBorderPhysics("Border2")
        initBorderPhysics("Border3")
        initBorderPhysics("Border4")
        self.physicsWorld.contactDelegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !matchManager!.isMatchStarted() {
            matchManager!.startMatch()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func update(_ currentTime: TimeInterval) {
        matchManager?.update()
    }
    func initBorderPhysics(_ border: String) {
        let nodeBorder = self.childNode(withName: "//\(border)") as? SKSpriteNode
        guard let sprite = nodeBorder else { return }
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        guard let physicsBody = sprite.physicsBody else { return }
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = CollisionManager.getObstacleCategory()
        physicsBody.collisionBitMask = CollisionManager.getNullMask()
        physicsBody.contactTestBitMask = CollisionManager.getNullMask()
    }
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        matchManager?.player?.rotatePlayer(swipeDirectionToPlayerDirection(sender.direction))
    }
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
    private func initializeSwipe() {
        swipeableView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)))
        guard let swipeView = swipeableView else { return }
        self.view?.addSubview(swipeView)
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }
    private func swipeDirectionToPlayerDirection(_ direction: UISwipeGestureRecognizer.Direction) -> MovementDirection {
        switch direction {
        case .up:
            return .movementUp
        case .down:
            return .movementDown
        case .left:
            return .movementLeft
        case .right:
            return .movementRight
        default:
            break
        }
        return .movementRight
    }

}
