//
//  ReaMath.swift
//  Rea
//
//  Created by Juan David Hurtado on 16/11/24.
//

import CoreGraphics
import ReaCore

public func translate(_ matrix: inout Mat4x4, to translation: Vec3) {
    matrix = float4x4(
        [            1,             0,             0, 0],
        [            0,             1,             0, 0],
        [            0,             0,             1, 0],
        [translation.x, translation.y, translation.z, 1]
    )
}

public func ortho(_ rect: CGRect, near: Float, far: Float) -> Mat4x4 {
    let left = Float(rect.origin.x)
    let right = Float(rect.origin.x + rect.width)
    let top = Float(rect.origin.y)
    let bottom = Float(rect.origin.y - rect.height)
    let X = float4(2 / (right - left), 0, 0, 0)
    let Y = float4(0, 2 / (top - bottom), 0, 0)
    let Z = float4(0, 0, 1 / (far - near), 0)
    let W = float4(
        (left + right) / (left - right),
        (top + bottom) / (bottom - top),
        near / (near - far),
        1)
    return .init(X, Y, Z, W)
}
