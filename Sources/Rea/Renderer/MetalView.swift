//
//  MetalView.swift
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

import MetalKit

class MetalView: MTKView {
    init() {
        let device = Container.retreive(MTLDevice.self)
        super.init(frame: .zero, device: device)
        
        colorPixelFormat = .bgra8Unorm
        clearColor = .init(red: 0.2, green: 0.5, blue: 0.1, alpha: 1)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
