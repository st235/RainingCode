import Foundation
import ScreenSaver
import SpriteKit
import shared

class RainingCodeView: ScreenSaverView {
    
    var spriteKitView: SKView?
    
    override var frame: NSRect {
        didSet {
            self.spriteKitView?.frame = frame
        }
    }
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Screen Saver view does not support initializing with coder")
    }
    
    override func startAnimation() {
        if spriteKitView == nil {
            let spriteKitView = SKView(frame: frame)

            spriteKitView.showsFPS = false
            spriteKitView.showsNodeCount = false
            spriteKitView.preferredFramesPerSecond = 60
            
            let textureFactory = BundleTextureProviderFactory()
            
            textureFactory.load(callback: { [weak self] provider in
                guard let self = self else { return }
                
                let scene = RainingCodeScene(size: self.bounds.size, backgroundColor: .black, textureProvider: provider)
                scene.scaleMode = .resizeFill
                scene.isUserInteractionEnabled = false
                spriteKitView.presentScene(scene)
            })

            self.spriteKitView = spriteKitView
            addSubview(spriteKitView)
        }
        
        super.startAnimation()
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        
        self.spriteKitView = nil
    }
    
}