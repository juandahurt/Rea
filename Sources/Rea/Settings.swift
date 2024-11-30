//
//  Settings.swift
//  Rea
//
//  Created by Juan David Hurtado on 24/11/24.
//

import Metal

struct Settings {
    static let pixelFormat = MTLPixelFormat.rgba8Unorm
    static let defaultClearColor = MTLClearColor(
        red: 0.8,
        green: 0.8,
        blue: 0.8,
        alpha: 1
    )
    static let depthPixelFormat = MTLPixelFormat.depth16Unorm
    
    static let maxNumEntities = 100
}
