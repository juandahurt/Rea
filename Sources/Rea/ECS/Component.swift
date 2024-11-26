//
//  Component.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Metal
import ReaCore
import ReaMath

public class Component {
    var isActive = false
}

public class TransformComponent: Component {
    public var position: Vec3 = .zero
    public var rotation: Float = 0
    public var scale: Float = 1
    
    var modelMatrix: Mat4x4 {
        let translated = translate(to: position)
        let rotated = rotate(by: [rotation, rotation, rotation])
        let scaled = ReaMath.scale(by: [scale, scale, 0])
        return translated * rotated * scaled
    }
}

public class RenderableComponent: Component {
    @MainActor
    var quad = Quad()
}
