import Foundation
import SpriteKit
import shared

class MainViewController: NSViewController {
    
    private var spriteKitView: SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spriteKitView = SKView(frame: view.bounds)
        
        spriteKitView.preferredFramesPerSecond = 60
        spriteKitView.showsFPS = true
        spriteKitView.showsDrawCount = true
        spriteKitView.showsNodeCount = true
        spriteKitView.ignoresSiblingOrder = true
        
        let textureProviderFactory = AssetsTextureProviderFactory()
        
        textureProviderFactory.load(callback: { provider in
            let rainingCodeScene = RainingCodeScene(size: spriteKitView.bounds.size, themeProvider: DefaultThemeProvider(), textureProvider: provider)
            rainingCodeScene.scaleMode = .resizeFill
            spriteKitView.presentScene(rainingCodeScene)
        })
        
        self.spriteKitView = spriteKitView
        view.addSubview(spriteKitView)
        
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false

        // these are 10.11-only APIs, but you can use the visual format language or any other autolayout APIs
        spriteKitView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        spriteKitView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spriteKitView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spriteKitView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}
