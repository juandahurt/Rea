//
//  Scene.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

open class Scene {
    public var entityManager = EntityManager()
    
    public init() {}
    
    open func update() { //TODO: add delta time (?))
        
    }
}


// TODO: move this to another file?
import Metal
import ReaCore
import ReaMath

@MainActor
extension Scene {
    func draw(with encoder: MTLRenderCommandEncoder, uniforms: inout Uniforms) {
        for e in entityManager.entities {
            let transform: TransformComponent = e.getComponent()
            translate(
                &uniforms.model,
                to: transform.position
            )
            encoder
                .setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 10)
            let renderComponent: RenderableComponent = e.getComponent()
            encoder.setVertexBuffer(renderComponent.quad.vertexBuffer, offset: 0, index: 0)
            encoder
                .drawIndexedPrimitives(
                    type: .triangle,
                    indexCount: renderComponent.quad.indices.count,
                    indexType: .uint16,
                    indexBuffer: renderComponent.quad.indexBuffer!,
                    indexBufferOffset: 0
                )
        }
    }
}
