import Cocoa

class ConfigurationView {
    
    @IBOutlet var window: NSWindow!
    @IBOutlet weak var backgroundColorPicker: NSColorWell!
    @IBOutlet weak var activeColorPicker: NSColorWell!
    @IBOutlet weak var inactiveColorPicker: NSColorWell!
    
    private let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
        
        let bundle = Bundle(for: ConfigurationView.self)
        bundle.loadNibNamed("Configuration", owner: self, topLevelObjects: nil)
        
        backgroundColorPicker.color = settings.backgroundColor
        activeColorPicker.color = settings.activeColor
        inactiveColorPicker.color = settings.inactiveColor
    }
    
    @IBAction func onBackgroundColorChanged(_ sender: NSColorWell) {
        settings.backgroundColor = sender.color
    }
    
    @IBAction func onActiveColorChanged(_ sender: NSColorWell) {
        settings.activeColor = sender.color
    }
    
    @IBAction func onInactiveColorChanged(_ sender: NSColorWell) {
        settings.inactiveColor = sender.color
    }
    
    @IBAction func onDoneClick(_ sender: NSButton) {
        guard let parent = window.sheetParent else {
          fatalError("Can not load parent")
        }
        parent.endSheet(window)
    }
}
