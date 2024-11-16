//
//  Graphics.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import Metal

@MainActor
struct Graphics {
    static let device: MTLDevice = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("GPU is not available")
        }
        return device
    }()
    
    static var commandQueue: MTLCommandQueue = {
        guard let commandQueue = device.makeCommandQueue() else {
            fatalError("Could not create command queue (?)")
        }
        return commandQueue
    }()
}
