import SpriteKit

public final class TextureProvider {
    
    private let textures: [SKTexture]
    private let texturesAvailableRange: Range<Int>
    
    public init(textures: [SKTexture]) {
        self.textures = textures
        self.texturesAvailableRange = 0..<textures.count
    }
    
    func peek() -> SKTexture {
        let index = Int.random(in: texturesAvailableRange)
        return textures[index]
    }
    
}
