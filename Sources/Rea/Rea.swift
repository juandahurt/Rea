// The Swift Programming Language
// https://docs.swift.org/swift-book

#if canImport(AppKit)
import AppKit
import Renderer
import MetalKit

public class ReaWindow: NSWindow {
    var renderer = Renderer()
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(
            contentRect: contentRect,
            styleMask: style,
            backing: backingStoreType,
            defer: flag
        )
        
        let metalView = MTKView()
        contentView = metalView
        metalView.delegate = renderer
        metalView.colorPixelFormat = .rgba8Unorm
    }
}
#endif
