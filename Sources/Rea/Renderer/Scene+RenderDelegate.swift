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
        entityManager.update()
        
        print("num entities: \(entityManager.entities.count)")
        for e in entityManager.entities {
            let transform = e.getComponent(TransformComponent.self)
            uniforms.model = transform.modelMatrix
            encoder.setVertexBytes(
                    &uniforms,
                    length: MemoryLayout<Uniforms>.stride,
                    index: 10
                )
            let renderComponent = e.getComponent(RenderableComponent.self)
            guard let mesh = renderComponent.mesh else { continue }
            encoder.setVertexBuffer(
                mesh.vertexBuffer,
                offset: 0,
                index: 0
            )
            for submesh in mesh.submeshes {
                encoder.drawIndexedPrimitives(
                    type: .triangle,
                    indexCount: submesh.indexCount,
                    indexType: submesh.indexType,
                    indexBuffer: submesh.indexBuffer,
                    indexBufferOffset: 0
                )
            }
        }
    }
    
    func renderer(_ renderer: Renderer, projectionMatrixForViewSize viewSize: CGSize) -> Mat4x4 {
        camera.getProjectionMatrix(forSize: viewSize)
    }
    
    func rendererViewMatrix(_ renderer: Renderer) -> Mat4x4 {
        camera.getViewMatrix()
    }
}
