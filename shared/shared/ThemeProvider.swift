import SpriteKit

public protocol ThemeProvider {
    
    var backgroundColor: SKColor { get }
    
    var activeColor: SKColor { get }
    
    var inactiveColor: SKColor { get }
    
}
