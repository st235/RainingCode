import SpriteKit

class CodeGlyph {
    
    private static let MAX_HEALTH = 1.0
    private static let MIN_HEALTH = 0.0
    private static let UPDATE_RANGE = 0...1.0
    
    let strideId: Int
    private let updateTime: TimeInterval
    private let node: SKSpriteNode
    
    private var health: Double
    private var lastUpdateTime: TimeInterval
    
    init(strideId: Int, node: SKSpriteNode) {
        self.strideId = strideId
        self.node = node
        
        self.health = CodeGlyph.MAX_HEALTH
        self.updateTime = Double.random(in: CodeGlyph.UPDATE_RANGE)
        self.lastUpdateTime = 0.0
    }
    
    func getNode() -> SKSpriteNode {
        return node
    }
    
    func updateTexture(texture: SKTexture) {
        node.texture = texture
    }
    
    func updateColor(color: SKColor) {
        node.color = color
    }
    
    func getPosition() -> CGPoint {
        return node.position
    }
    
    func shouldUpdate(currentTime: TimeInterval) -> Bool {
        if (currentTime - lastUpdateTime >= updateTime) {
            lastUpdateTime = currentTime;
            return true;
        }
        
        return false;
    }
    
    func isAlive() -> Bool {
        return health > CodeGlyph.MIN_HEALTH
    }
    
    func hurt(with damage: Double) {
        health -= damage
        node.color = node.color.withAlphaComponent(CGFloat(health))
    }
    
}
