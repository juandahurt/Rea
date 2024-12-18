@MainActor
public struct Rea {
    public static func load() {
        loadDependencies()
    }
    
    private static func loadDependencies() {
        Container.register { _ in
            guard let device = MTLCreateSystemDefaultDevice() else {
                fatalError("GPU not available (?)")
            }
            return device
        }
        
        Container.register { c in
            let device = c.retreive(MTLDevice.self)
            guard let queue = device.makeCommandQueue() else {
                fatalError("Couldn't make a command queue")
            }
            return queue
        }
    }
}


#if canImport(AppKit)
import AppKit
import MetalKit

public class ReaWindow: NSWindow {
    var renderer = Renderer()
    var metalView = MetalView()
    var input = Input()
    
    public var scene: Scene? {
        didSet {
            renderer.delegate = scene
            input.mouseEventHandler = scene
            input.keyEventHandler = scene
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
