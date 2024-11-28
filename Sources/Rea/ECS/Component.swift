//
//  Component.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import MetalKit
import ReaCore
import ReaMath

public class Component {
    var isActive = false
}

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
        guard let assetURL = Bundle.main.url(
            forResource: fileName,
            withExtension: ext
        ) else {
            print("\(fileName).\(ext) not found!")
            return
        }
        
        let device = Container.retreive(MTLDevice.self)
        let bufferAllocator = MTKMeshBufferAllocator(device: device)
        
        let asset = MDLAsset(
            url: assetURL,
            vertexDescriptor: .defaultLayout,
            bufferAllocator: bufferAllocator
        )
        
        if let mdlMeshes = asset.childObjects(of: MDLMesh.self) as? [MDLMesh], !mdlMeshes.isEmpty {
            if mdlMeshes.count > 1 {
                print("several models found in file \(fileName).\(ext)")
                print("only the first one will be linked with the entity")
            }
            let mdlMesh = mdlMeshes.first!
            mesh = Mesh(from: mdlMesh)
        } else {
            print("couldn't find any model in file \(fileName).\(ext)")
        }
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
