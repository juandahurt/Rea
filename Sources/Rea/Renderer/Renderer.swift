//
//  Renderer.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import MetalKit
import ReaCore
import ReaMath

// Do I really need to pass the renderer to the delegate? Probably not
@MainActor
protocol RendererDelegate: AnyObject {
    func renderer(_ renderer: Renderer, updateSceneWith deltaTime: Float)
    func renderer(_ renderer: Renderer, renderSceneUsing encoder: MTLRenderCommandEncoder, uniforms: inout Uniforms)
    func renderer(_ renderer: Renderer, projectionMatrixForViewSize viewSize: CGSize) -> Mat4x4
    func rendererViewMatrix(_ renderer: Renderer) -> Mat4x4
}

@MainActor
class Renderer: NSObject {
    weak var delegate: RendererDelegate?
    
    var pipelineState: MTLRenderPipelineState?
    var depthStencilState: MTLDepthStencilState?
    var library: MTLLibrary!
    
    var uniforms = Uniforms()
    
    private var lasTime = CFAbsoluteTimeGetCurrent()
    
    public override init() {
        super.init()
        setupPipeline()
    }
    
    func setupPipeline() {
        // TODO: move this logic to another place
        let device = Container.retreive(MTLDevice.self)
        guard let library = try? device.makeDefaultLibrary(bundle: .module) else {
            fatalError("Couldn't make default Metal library")
        }
        self.library = library
        let vertexFunction = library.makeFunction(name: "vertex_function")
        let fragmentFunction = library.makeFunction(name: "fragment_function")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexDescriptor = .defaultLayout
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = Settings.pixelFormat
        pipelineDescriptor.depthAttachmentPixelFormat = Settings.depthPixelFormat
        pipelineState = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        
        let depthDescriptor = MTLDepthStencilDescriptor()
        depthDescriptor.depthCompareFunction = .lessEqual
        depthDescriptor.isDepthWriteEnabled = true
        depthStencilState = device.makeDepthStencilState(descriptor: depthDescriptor)
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        guard let delegate else { return }
        uniforms.projection = delegate.renderer(self, projectionMatrixForViewSize: size)
    }
    
    func draw(in view: MTKView) {
        guard let delegate else {
            fatalError("renderer delegate cannot be nil!")
        }
        let commandQueue = Container.retreive(MTLCommandQueue.self)
        guard
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let passDescriptor = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable,
            let pipelineState = pipelineState
        else {
            return
        }
        let deltaTime = calculateDeltaTime()
        delegate.renderer(self, updateSceneWith: deltaTime)
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)!
        renderEncoder.setTriangleFillMode(.lines)
        renderEncoder.setDepthStencilState(depthStencilState)
        renderEncoder.setRenderPipelineState(pipelineState)
        
        // TODO: find a way to prevent updating the projection matrix avery frame
        uniforms.projection = delegate.renderer(
            self,
            projectionMatrixForViewSize: view.frame.size
        )
        uniforms.view = delegate.rendererViewMatrix(self)
        delegate.renderer(self, renderSceneUsing: renderEncoder, uniforms: &uniforms)

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
