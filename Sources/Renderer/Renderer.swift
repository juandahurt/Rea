//
//  Renderer.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import MetalKit

@MainActor
public class Renderer: NSObject, MTKViewDelegate {
    var device: MTLDevice?
    
    public override init() {
        device = Graphics.device
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    public func draw(in view: MTKView) {
        guard
            let commandBuffer = Graphics.commandQueue.makeCommandBuffer(),
            let passDescriptor = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable
        else {
            return
        }
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)
        renderEncoder?.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
