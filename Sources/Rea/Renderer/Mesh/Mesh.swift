//
//  Mesh.swift
//  Rea
//
//  Created by Juan Hurtado on 28/11/24.
//

import MetalKit

@MainActor
struct Mesh {
    var name: String = ""
    var vertexBuffer: MTLBuffer?
    var submeshes: [Submesh] = []
    
    init(from mdlMesh: MDLMesh) {
        let device = Container.retreive(MTLDevice.self)
        guard let mtkMesh = try? MTKMesh(mesh: mdlMesh, device: device) else {
            print("couldn't create Metal mesh")
            return
        }
        name = mtkMesh.name
        vertexBuffer = mtkMesh.vertexBuffers.first?.buffer
        
        for mtkSubmesh in mtkMesh.submeshes {
            submeshes.append(.init(from: mtkSubmesh))
        }
    }
}

struct Submesh {
    var indexBuffer: MTLBuffer
    var indexCount: Int
    var indexType: MTLIndexType
    
    init(from mtkSubmesh: MTKSubmesh) {
        indexBuffer = mtkSubmesh.indexBuffer.buffer
        indexCount = mtkSubmesh.indexCount
        indexType = mtkSubmesh.indexType
    }
}
