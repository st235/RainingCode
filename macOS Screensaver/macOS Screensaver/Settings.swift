import ScreenSaver

class Settings {
    
    private static let KEY_BACKGROUND_COLOR = "key.color.background"
    private static let KEY_INACTIVE_COLOR = "key.color.inactive"
    private static let KEY_ACTIVE_COLOR = "key.color.active"

    let screenSaverDefaults = createDefaults()
    
    var backgroundColor: NSColor {
        get {
            return dataToColor(color: screenSaverDefaults.object(forKey: Settings.KEY_BACKGROUND_COLOR) as? Data, defaultColor: .black)
        }
        set(value) {
            screenSaverDefaults.setValue(colorToNSData(color: value), forKey: Settings.KEY_BACKGROUND_COLOR)
            screenSaverDefaults.synchronize()
        }
    }
    
    var inactiveColor: NSColor {
        get {
            return dataToColor(color: screenSaverDefaults.object(forKey: Settings.KEY_INACTIVE_COLOR) as? Data, defaultColor: .green)
        }
        set(value) {
            screenSaverDefaults.setValue(colorToNSData(color: value), forKey: Settings.KEY_INACTIVE_COLOR)
            screenSaverDefaults.synchronize()
        }
    }
    
    var activeColor: NSColor {
        get {
            return dataToColor(color: screenSaverDefaults.object(forKey: Settings.KEY_ACTIVE_COLOR) as? Data, defaultColor: .white)
        }
        set(value) {
            screenSaverDefaults.setValue(colorToNSData(color: value), forKey: Settings.KEY_ACTIVE_COLOR)
            screenSaverDefaults.synchronize()
        }
    }
    
    init() {
        let defaultValues: [String:Any] = [
            Settings.KEY_BACKGROUND_COLOR: colorToNSData(color: .black),
            Settings.KEY_INACTIVE_COLOR: colorToNSData(color: .green),
            Settings.KEY_ACTIVE_COLOR: colorToNSData(color: .white)
        ]
        
        screenSaverDefaults.register(defaults: defaultValues)
    }
    
    private func dataToColor(color: Data?, defaultColor: NSColor) -> NSColor {
        guard let color = color else {
            return defaultColor
        }
        return try! NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: color) ?? defaultColor
    }
    
    private func colorToNSData(color: NSColor) -> Data {
        return try! NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
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
