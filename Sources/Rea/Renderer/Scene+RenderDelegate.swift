//
//  Scene+RenderDelegate.swift
//  Rea
//
//  Created by Juan David Hurtado on 18/11/24.
//

import Metal
import ReaCore
import ReaMath

extension Scene: RendererDelegate {
    func renderer(_ renderer: Renderer, updateSceneWith deltaTime: Float) {
        update(deltaTime: deltaTime)
    }
    
    func renderer(
        _ renderer: Renderer,
        renderSceneUsing encoder: any MTLRenderCommandEncoder,
        uniforms: inout Uniforms
    ) {
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
