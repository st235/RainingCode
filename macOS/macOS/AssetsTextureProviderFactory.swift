import SpriteKit
import shared

class AssetsTextureProviderFactory: TextureProviderFactory {
    
    private static let ABC_CAPACITY = 56
    
    func load(callback: @escaping TextureLoadCallback) {
        var textures = [SKTexture]()
        
        let atlas = SKTextureAtlas(named: "glyphs")
        
        for i in 1...AssetsTextureProviderFactory.ABC_CAPACITY {
            textures.append(atlas.textureNamed(String(i)))
        }
        
        let textureProvider = TextureProvider(textures: textures)
        callback(textureProvider)
    }
    
}
