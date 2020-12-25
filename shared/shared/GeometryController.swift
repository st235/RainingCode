import Foundation

final class GeometryController {
    
    // aspect ratio is calculated as width / height
    private static let GLYPH_ASPECT_RATIO = CGFloat(128.0/132.0)
    
    private let viewportSize: CGSize
    private let glyphSize: CGSize
    
    private let glyphsColumnsCount: CGFloat
    private let columnsRange: Range<Int>
    
    init(viewportSize: CGSize, glyphsColumnsCount: CGFloat) {
        self.viewportSize = viewportSize
        self.glyphsColumnsCount = glyphsColumnsCount
        self.columnsRange = 0..<Int(glyphsColumnsCount)
        
        let glyphWidth = (viewportSize.width / glyphsColumnsCount).rounded(FloatingPointRoundingRule.up)
        
        // aspect ration is width/height =>
        // glypthHeight = glyphWidth * height / width =>
        // glypthHeight = glyphWidth / aspectRatio
        let glyphHeight = glyphWidth / GeometryController.GLYPH_ASPECT_RATIO
        
        glyphSize = CGSize(width: glyphWidth, height: glyphHeight)
    }
    
    func getColumnsCount() -> CGFloat {
        return glyphsColumnsCount
    }
    
    func getGlyphSize() -> CGSize {
        return glyphSize
    }
    
    func getRandomPosition() -> CGPoint {
        let column = Int.random(in: columnsRange)
        let randomOffset: CGFloat = viewportSize.height * 0.25 * CGFloat(Double.random(in: 0...1))
        return CGPoint(x: CGFloat(column) * glyphSize.width, y: viewportSize.height - randomOffset)
        
    }
    
    func nextGlyphSize(from point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x, y: point.y - glyphSize.height)
    }
    
    func isOutOfViewport(point: CGPoint) -> Bool {
        if point.x < 0 || point.x > viewportSize.width {
            return true
        }
        
        if (point.y < 0 || point.y > viewportSize.height) {
            return true
        }
        
        return false
    }
    
}
