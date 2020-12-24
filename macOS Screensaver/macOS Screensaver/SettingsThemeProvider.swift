import SpriteKit
import shared

class SettingsThemeProvider: ThemeProvider {
    
    private let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
    }
    
    var backgroundColor: SKColor {
        get {
            return nsColorToSkColor(color: settings.backgroundColor)
        }
    }
    
    var activeColor: SKColor {
        get {
            return nsColorToSkColor(color: settings.activeColor)
        }
    }
    
    var inactiveColor: SKColor {
        get {
            return nsColorToSkColor(color: settings.inactiveColor)
        }
    }
    
    private func nsColorToSkColor(color: NSColor) -> SKColor {
        return SKColor(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent, alpha: color.alphaComponent)
    }
    
}
