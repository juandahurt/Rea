//
//  Renderer.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import MetalKit
import Shared

@MainActor
public protocol RendererDelegate: AnyObject {
    /// Called just before rendering the current frame
    func willRenderFrame()
}

@MainActor
public class Renderer: NSObject {
    public weak var delegate: RendererDelegate?
    
    var pipelineState: MTLRenderPipelineState?
   
    let quad = Quad()
    
    public override init() {
        super.init()
        setupPipeline()
    }
    
    func setupPipeline() {
        // TODO: move this logic to another place
        guard let library = try? Graphics.device.makeDefaultLibrary(bundle: .module) else {
            fatalError("Couldn't make default Metal library")
        }
        let vertexFunction = library.makeFunction(name: "vertex_function")
        let fragmentFunction = library.makeFunction(name: "fragment_function")
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        vertexDescriptor.attributes[1].format = .float4
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride + MemoryLayout<SIMD4<Float>>.stride
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineState = try? Graphics.device
            .makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
}

extension Renderer: MTKViewDelegate {
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    public func draw(in view: MTKView) {
        guard
            let commandBuffer = Graphics.commandQueue.makeCommandBuffer(),
            let passDescriptor = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable,
            let pipelineState = pipelineState
        else {
            return
        }
        
        delegate?.willRenderFrame()
        
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)
       
        renderEncoder?.setVertexBuffer(
            quad.vertexBuffer,
            offset: 0,
            index: 0
        )
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?
            .drawIndexedPrimitives(
                type: .triangle,
                indexCount: quad.indices.count,
                indexType: .uint16,
                indexBuffer: quad.indexBuffer!,
                indexBufferOffset: 0
            )
        
        renderEncoder?.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
