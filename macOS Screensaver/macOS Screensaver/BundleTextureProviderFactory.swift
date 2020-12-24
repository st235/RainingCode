import SpriteKit
import shared

class BundleTextureProviderFactory: TextureProviderFactory {
    
    private static let ABC_CAPACITY = 56
    
    private let bundle: Bundle
    
    init() {
        self.bundle = Bundle(for: type(of: self))
    }
    
    func load(callback: @escaping TextureLoadCallback) {
        var textures = [SKTexture]()
        
        for id in 1...BundleTextureProviderFactory.ABC_CAPACITY {
            let path = bundle.path(forResource: "\(id).png", ofType: nil)
            textures.append(SKTexture(imageNamed: path ?? ""))
        }
        
        let textureProvider = TextureProvider(textures: textures)
        callback(textureProvider)
    }
    
}

