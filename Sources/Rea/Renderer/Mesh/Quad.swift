//
//  Quad.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import ReaCore
import Metal

@MainActor
struct Quad {
    var vertices: [Vertex] = [
        .init(position: [-1, -1, 0], color: [1, 0, 0, 1]),
        .init(position: [1, 1, 0], color: [1, 0, 1, 1]),
        .init(position: [-1, 1, 0], color: [1, 1, 0, 1]),
        .init(position: [1, -1, 0], color: [0, 0, 1, 1]),
    ]
    var vertexBuffer: MTLBuffer?
    
    var indices: [UInt16] = [
        0, 1, 2,
        0, 3, 1
    ]
    var indexBuffer: MTLBuffer?
    
    init() {
        let device = Container.retreive(MTLDevice.self)
        
        vertexBuffer = device.makeBuffer(
            bytes: vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
        indexBuffer = device.makeBuffer(
            bytes: indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        )
    }
}
