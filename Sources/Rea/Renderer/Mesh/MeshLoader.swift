//
//  MeshLoader.swift
//  Rea
//
//  Created by Juan Hurtado on 28/11/24.
//

import MetalKit

@MainActor
class MeshLoader {
    func load(fromFile fileName: String, withExtension ext: String) -> Mesh? {
        guard let assetURL = Bundle.main.url(
            forResource: fileName,
            withExtension: ext
        ) else {
            print("\(fileName).\(ext) not found!")
            return nil
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
            return Mesh(from: mdlMesh)
        } else {
            print("couldn't find any model in file \(fileName).\(ext)")
        }
        return nil
    }
}
