import Foundation
import SpriteKit

public final class RainingCodeScene: SKScene, GlyphsController.Delegate {
    
    private let themeProvider: ThemeProvider
    private let textureProvider: TextureProvider
    private let geometryController: GeometryController
    private let glyphsController: GlyphsController
    
    private var appearanceUpdateTime: TimeInterval = 0.025
    private var spawnTime: TimeInterval = 0.05
    private var nextStepUpdateTime: TimeInterval = 0.05
    
    private var lastAppearanceUpdateTime: TimeInterval = 0
    private var lastSpawnTime: TimeInterval = 0
    private var lastNextStepUpdateTime: TimeInterval = 0
    
    public init(size: CGSize, themeProvider: ThemeProvider, textureProvider: TextureProvider) {
        self.themeProvider = themeProvider
        self.textureProvider = textureProvider
        self.geometryController = GeometryController(viewportSize: size, glyphsColumnsCount: 80)
        self.glyphsController = GlyphsController(themeProvider: themeProvider, texturesProvider: textureProvider, geometryController: geometryController)
        
        super.init(size: size)
        self.backgroundColor = themeProvider.backgroundColor
        
        self.glyphsController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func sceneDidLoad() {
        glyphsController.createFirstGeneration()
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if lastAppearanceUpdateTime == 0 || currentTime - lastAppearanceUpdateTime >= appearanceUpdateTime {
            lastAppearanceUpdateTime = currentTime
            glyphsController.updateAppearance(currentTime: currentTime)
        }
        
        if lastSpawnTime == 0 || currentTime - lastSpawnTime >= spawnTime {
            lastSpawnTime = currentTime
            glyphsController.spawnNewGlyph()
        }
        
        if lastNextStepUpdateTime == 0 || currentTime - lastNextStepUpdateTime >= nextStepUpdateTime {
            lastNextStepUpdateTime = currentTime
            glyphsController.updateGenerations()
        }
    }
    
    func onAttach(node: SKNode) {
        addChild(node)
    }
    
    func onDetach(node: SKNode) {
        node.removeFromParent()
    }
        
}
