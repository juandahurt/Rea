//
//  Renderer.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import MetalKit
import Shared

@MainActor
public class Renderer: NSObject {
    var pipelineState: MTLRenderPipelineState?
   
    var vertices: [Vertex] = [
        .init(
            position: [0, 0, 0],
            color: [1, 0, 0, 1]
        ),
        .init(
            position: [1, 1, 0],
            color: [0, 1, 0, 1]
        ),
        .init(
            position: [0, 0.5, 0],
            color: [0, 0, 1, 1]
        )
    ]
    var vertexBuffer: MTLBuffer?
    
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
        
        vertexBuffer = Graphics.device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
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
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)
       
        renderEncoder?.setVertexBuffer(
            vertexBuffer,
            offset: 0,
            index: 0
        )
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.drawPrimitives(
            type: .triangle,
            vertexStart: 0,
            vertexCount: vertices.count
        )
        
        renderEncoder?.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
