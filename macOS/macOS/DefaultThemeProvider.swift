import SpriteKit
import shared

class DefaultThemeProvider: ThemeProvider {
    
    var backgroundColor: SKColor {
        get {
            return .black
        }
    }
    
    var activeColor: SKColor {
        get {
            return .white
        }
    }
    
    var inactiveColor: SKColor {
        get {
            return .green
        }
    }
    
}
