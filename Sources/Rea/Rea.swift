#if canImport(AppKit)
import AppKit
import MetalKit

@MainActor
class Rea { // this is just like a scene manager?
    var scenes: [String: Scene] = [:] // TODO: maybe use an int as key?
    
    static var currentScene: Scene? // not sure if this shouldn't be an optional
}

public class ReaWindow: NSWindow {
    var renderer = Renderer()
    var metalView = MetalView()
    public var scene: Scene? {
        didSet {
            Rea.currentScene = scene
        }
    }
    
    public override init(
        contentRect: NSRect,
        styleMask style: NSWindow.StyleMask,
        backing backingStoreType: NSWindow.BackingStoreType,
        defer flag: Bool
    ) {
        super.init(
            contentRect: contentRect,
            styleMask: style,
            backing: backingStoreType,
            defer: flag
        )
        
        contentView = metalView
        metalView.delegate = renderer
        renderer.delegate = self
    }
}
import Metal
import ReaCore

extension ReaWindow: RendererDelegate {
    func updateScene() {
        Rea.currentScene?.update()
    }
    
    func drawScene(with encoder: MTLRenderCommandEncoder, uniforms: inout Uniforms) {
        Rea.currentScene?.draw(with: encoder, uniforms: &uniforms)
    }
}
#endif
