//
//  Component.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import MetalKit
import ReaCore
import ReaMath

public class Component {}

public class TransformComponent: Component {
    public var position: Vec3 = .zero
    public var rotation: Vec3 = .zero
    public var scale: Float = 1
    
    var modelMatrix: Mat4x4 {
        let translated = translate(to: position)
        let rotated = rotate(by: rotation)
        let scaled = ReaMath.scale(by: [scale, scale, scale])
        return translated * rotated * scaled
    }
}

public class RenderableComponent: Component {
    var mesh: Mesh?
    
    @MainActor
    public func setMesh(fileName: String, ext: String) {
        // how to handle the error?
        // I suppose that printing an error is enough for now
        let meshLoader = MeshLoader()
        mesh = meshLoader.load(fromFile: fileName, withExtension: ext)
    }
}


extension MTLVertexDescriptor {
    static var defaultLayout: MTLVertexDescriptor? {
        MTKMetalVertexDescriptorFromModelIO(.defaultLayout)
    }
}


// Vertex descriptor associated with a mesh loaded from an
// asset
extension MDLVertexDescriptor {
    static var defaultLayout: MDLVertexDescriptor {
        let vertexDescriptor = MDLVertexDescriptor()
        var offset = 0
        vertexDescriptor.attributes[0] = MDLVertexAttribute(
            name: MDLVertexAttributePosition,
            format: .float3,
            offset: 0,
            bufferIndex: 0)
        offset += MemoryLayout<SIMD3<Float>>.stride
        vertexDescriptor.layouts[0] = MDLVertexBufferLayout(stride: offset)
        return vertexDescriptor
    }
}
