//
//  Quad.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Shared
import Metal

@MainActor
struct Quad {
    var vertices: [Vertex] = [
        .init(position: [-0.25, -0.25, 0], color: [1, 0, 0, 1]),
        .init(position: [0.25, 0.25, 0], color: [1, 0, 1, 1]),
        .init(position: [-0.25, 0.25, 0], color: [1, 1, 0, 1]),
        .init(position: [0.25, -0.25, 0], color: [0, 0, 1, 1]),
    ]
    var vertexBuffer: MTLBuffer?
    
    var indices: [UInt16] = [
        0, 1, 2,
        0, 3, 1
    ]
    var indexBuffer: MTLBuffer?
    
    init() {
        vertexBuffer = Graphics.device.makeBuffer(
            bytes: vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        )
        indexBuffer = Graphics.device.makeBuffer(
            bytes: indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        )
    }
}
