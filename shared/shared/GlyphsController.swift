import SpriteKit

protocol GlyphsControllerDelegate: class {
    
    func onAttach(node: SKNode)
    
    func onDetach(node: SKNode)
    
}

final class GlyphsController {
    
    typealias Delegate = GlyphsControllerDelegate
    
    private static let DYING_RANGE = 0.05...0.15

    private let texturesProvider: TextureProvider
    private let geometryController: GeometryController
    private var stridesDamage: [Double]
    
    private var oldGeneration: [CodeGlyph]
    private var activeGeneration: [CodeGlyph]
    
    weak var delegate: Delegate? = nil
    
    init(texturesProvider: TextureProvider, geometryController: GeometryController) {
        self.texturesProvider = texturesProvider
        self.geometryController = geometryController
        self.stridesDamage = Array(repeating: 0.0, count: Int(geometryController.getColumnsCount()))
        
        self.oldGeneration = []
        self.activeGeneration = []
        
        for i in 0..<Int(geometryController.getColumnsCount()) {
            stridesDamage[i] = Double.random(in: GlyphsController.DYING_RANGE)
        }
    }
    
    func createFirstGeneration() {
        for i in 0..<Int(geometryController.getColumnsCount()) {
            let shouldSpawn = Bool.random()
            
            if !shouldSpawn {
                continue
            }
            
            let glyph = createGlyph(strideId: i, position: geometryController.getRandomPosition())
            activeGeneration.append(glyph)
            
            delegate?.onAttach(node: glyph.getNode())
        }
    }
    
    func spawnNewGlyph() {
        let stride = Int.random(in: 0..<Int(geometryController.getColumnsCount()))
        let glyph = createGlyph(strideId: stride, position: geometryController.getRandomPosition())
        activeGeneration.append(glyph)
        delegate?.onAttach(node: glyph.getNode())
    }
    
    func updateAppearance(currentTime: TimeInterval) {
        for oldNode in oldGeneration {
            if oldNode.shouldUpdate(currentTime: currentTime) {
                oldNode.updateTexture(texture: texturesProvider.peek())
            }
        }
    }
    
    func updateGenerations() {
        var newOldGeneration = [CodeGlyph]()
        var newActiveGeneration = [CodeGlyph]()
        
        for activeNode in activeGeneration {
            newOldGeneration.append(activeNode)
            activeNode.updateColor(color: .green)
            
            let shouldDrop = Double.random(in: 0...1)
            
            if shouldDrop < 0.02 {
                continue
            }
            
            let newActiveNode = createGlyph(strideId: activeNode.strideId, position: self.geometryController.nextGlyphSize(from: activeNode.getPosition()))
            newActiveGeneration.append(newActiveNode)
            delegate?.onAttach(node: newActiveNode.getNode())
        }
        
        for oldNode in oldGeneration {
            let damage = stridesDamage[oldNode.strideId]
            oldNode.hurt(with: damage)
            
            if !oldNode.isAlive() {
                delegate?.onDetach(node: oldNode.getNode())
                continue
            }
            
            newOldGeneration.append(oldNode)
        }
        
        self.activeGeneration = newActiveGeneration
        self.oldGeneration = newOldGeneration
    }
    
    private func createGlyph(strideId id: Int, position: CGPoint) -> CodeGlyph {
        let glyph = CodeGlyph(strideId: id, node: createSkNode(position: position))
        return glyph
    }
    
    private func createSkNode(position: CGPoint) -> SKSpriteNode {
        let skSpriteNode = SKSpriteNode(texture: self.texturesProvider.peek(), color: .white, size: self.geometryController.getGlyphSize())
        skSpriteNode.position = position
        skSpriteNode.colorBlendFactor = 1.0
        return skSpriteNode
    }
    
}
