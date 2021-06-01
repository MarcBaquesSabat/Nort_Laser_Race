import SpriteKit

public extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    func moveTowards(_ point: CGPoint, _ distance: CGFloat) -> CGPoint {
        let vector = CGPoint(x: point.x - self.x, y: point.y - self.y)
        let vectorNormalize = vector.normalized()
        let endPoint = CGPoint(x: self.x + (vectorNormalize.x * distance), y: self.y + (vectorNormalize.y * distance))
        return endPoint
    }
    func distanceTo(_ point: CGPoint) -> CGFloat {
        let point = CGPoint(x: self.x - point.x, y: self.y - point.y)
        let length = point.length()
        return length
    }
    func normalized() -> CGPoint {
        let len = length()
        return len > 0 ? CGPoint(x: self.x / len, y: self.y / len) : CGPoint.zero
    }
}
