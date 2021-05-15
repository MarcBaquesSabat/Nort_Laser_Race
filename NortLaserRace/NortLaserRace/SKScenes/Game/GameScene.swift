import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene {
    let matchManager: MatchManager = MatchManager()
    var player1: PlayerViewModel?
    var player2: PlayerViewModel?
    var swipeableView: UIView?
    override func didMove(to view: SKView) {
        player1 = PlayerViewModel(PlayerModel(), PlayerView("Player 1", "Player01", self))
        player2 = PlayerViewModel(PlayerModel(), PlayerView("Player 2", "Player01", self))
        player1?.setPosition(CGPoint(x: 400, y: 0))
        player2?.setPosition(CGPoint(x: -200, y: 0))
        swipeableView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)))
        guard let swipeView = swipeableView else { return }
        self.view?.addSubview(swipeView)
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        swipeView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            print("Swipe up")
            break
        case .down:
            print("Swipe down")
            break
        case .left:
            print("Swipe left")
            break
        case .right:
            print("Swipe right")
            break
        default:
            break
        }
    }
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func update(_ currentTime: TimeInterval) {
    }
}
