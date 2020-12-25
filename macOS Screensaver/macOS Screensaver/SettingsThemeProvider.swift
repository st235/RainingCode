import SpriteKit
import shared

class SettingsThemeProvider: ThemeProvider {
    
    private let settings: Settings

    init(settings: Settings) {
        self.settings = settings
    }
    
    var backgroundColor: SKColor {
        get {
            return settings.backgroundColor
        }
    }
    
    var activeColor: SKColor {
        get {
            return settings.activeColor
        }
    }
    
    var inactiveColor: SKColor {
        get {
            return settings.inactiveColor
        }
    }

}
