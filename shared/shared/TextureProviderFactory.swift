public typealias TextureLoadCallback = (TextureProvider) -> Void

public protocol TextureProviderFactory {
    
    func load(callback: @escaping TextureLoadCallback)
    
}

