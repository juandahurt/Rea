#if canImport(AppKit)
import AppKit
import MetalKit

public class ReaWindow: NSWindow {
    var renderer = Renderer()
    var metalView = MetalView()
    
    public var scene: Scene? {
        didSet {
            renderer.delegate = scene
            Input.instance.eventHandler = scene
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
        acceptsMouseMovedEvents = true
    }
}
#endif
