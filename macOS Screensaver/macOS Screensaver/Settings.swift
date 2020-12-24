import ScreenSaver

class Settings {
    
    private static let KEY_BACKGROUND_COLOR = "keys.background"
    private static let KEY_INACTIVE_COLOR = "keys.inactive"
    private static let KEY_ACTIVE_COLOR = "keys.active"

    let screenSaverDefaults = createDefaults()
    
    var backgroundColor: NSColor {
        get {
            return uintToColor(color: screenSaverDefaults.integer(forKey: Settings.KEY_BACKGROUND_COLOR))
        }
        set(value) {
            screenSaverDefaults.setValue(colorToInt(color: value), forKey: Settings.KEY_BACKGROUND_COLOR)
            screenSaverDefaults.synchronize()
        }
    }
    
    var inactiveColor: NSColor {
        get {
            return uintToColor(color: screenSaverDefaults.integer(forKey: Settings.KEY_INACTIVE_COLOR))
        }
        set(value) {
            screenSaverDefaults.setValue(colorToInt(color: value), forKey: Settings.KEY_INACTIVE_COLOR)
            screenSaverDefaults.synchronize()
        }
    }
    
    var activeColor: NSColor {
        get {
            return uintToColor(color: screenSaverDefaults.integer(forKey: Settings.KEY_ACTIVE_COLOR))
        }
        set(value) {
            screenSaverDefaults.setValue(colorToInt(color: value), forKey: Settings.KEY_ACTIVE_COLOR)
            screenSaverDefaults.synchronize()
        }
    }
    
    func register() {
        let defaultValues: [String:Any] = [
            Settings.KEY_BACKGROUND_COLOR: colorToInt(color: .black),
            Settings.KEY_INACTIVE_COLOR: colorToInt(color: .green),
            Settings.KEY_ACTIVE_COLOR: colorToInt(color: .white)
        ]
        
        screenSaverDefaults.register(defaults: defaultValues)
    }
    
    private func uintToColor(color: Int) -> NSColor {
        let red = (color >> 16) & 0xFF
        let green = (color >> 8) & 0xFF
        let blue = (color >> 0) & 0xFF
        
        return NSColor(red: CGFloat(red) / 0xFF, green: CGFloat(green) / 0xFF, blue: CGFloat(blue) / 0xFF, alpha: 1.0)
    }
    
    private func colorToInt(color: NSColor) -> Int {
        return Int(color.redComponent * 0xFF) << 16 + Int(color.greenComponent * 0xFF) << 8 + Int(color.blueComponent)
    }
    
    private static func createDefaults() -> ScreenSaverDefaults {
        guard let id = Bundle(for: Settings.self).bundleIdentifier else {
            fatalError("Can not load bundle")
        }
        
        guard let defaults = ScreenSaverDefaults(forModuleWithName: id) else {
            fatalError("Can not create defaults for a bundle with id \(id)")
        }
        
        return defaults
    }
}
