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
        
        colorPixelFormat = Settings.pixelFormat
        clearColor = Settings.defaultClearColor
        depthStencilPixelFormat = Settings.depthPixelFormat
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
