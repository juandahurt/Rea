//
//  Renderer.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import MetalKit
import ReaCore
import ReaMath

@MainActor
protocol RendererDelegate: AnyObject {
    func renderer(_ renderer: Renderer, updateSceneWith deltaTime: Float)
    func renderer(_ renderer: Renderer, renderSceneUsing encoder: MTLRenderCommandEncoder, uniforms: inout Uniforms)
}

@MainActor
class Renderer: NSObject {
    weak var delegate: RendererDelegate?
    
    var pipelineState: MTLRenderPipelineState?
   
    var uniforms = Uniforms()
    
    private var lasTime = CFAbsoluteTimeGetCurrent()
    
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
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        let aspect = size.width / size.height
        let viewSize: CGFloat = 10
        uniforms.projection = ortho(
            .init(
                x: -viewSize * aspect * 0.5,
                y: viewSize * 0.5,
                width: viewSize * aspect,
                height: viewSize
            ),
            near: 0,
            far: 10
        )
    }
    
    func draw(in view: MTKView) {
        guard
            let commandBuffer = Graphics.commandQueue.makeCommandBuffer(),
            let passDescriptor = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable,
            let pipelineState = pipelineState
        else {
            return
        }
        let deltaTime = calculateDeltaTime()
        delegate?.renderer(self, updateSceneWith: deltaTime)
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)!
        renderEncoder.setRenderPipelineState(pipelineState)
        
        let viewSize: CGFloat = view.bounds.width / 4
        let aspect = view.bounds.width / view.bounds.height
        uniforms.projection = ortho(
            .init(
                x: -viewSize * aspect * 0.5,
                y: viewSize * 0.5,
                width: viewSize * aspect,
                height: viewSize
            ),
            near: 0,
            far: 10
        )
        uniforms.view = translate(to: [0, 0, 0])
        delegate?.renderer(self, renderSceneUsing: renderEncoder, uniforms: &uniforms)

        renderEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}

extension Renderer {
    func calculateDeltaTime() -> Float {
        let currentTime = CFAbsoluteTimeGetCurrent()
        let deltaTime = Float(currentTime - lasTime)
        lasTime = currentTime
        return deltaTime
    }
}
