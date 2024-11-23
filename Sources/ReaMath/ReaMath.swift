//
//  ReaMath.swift
//  Rea
//
//  Created by Juan David Hurtado on 16/11/24.
//

import CoreGraphics
import ReaCore

extension Mat4x4 {
    public static var identity: Mat4x4 {
        matrix_identity_float4x4
    }
}

public func scale(by value: Vec3) -> Mat4x4 {
    let matrix = float4x4(
        [value.x,         0,         0, 0],
        [        0, value.y,         0, 0],
        [        0,       0,   value.z, 0],
        [        0,       0,         0, 1]
    )
    return matrix
}

// TODO: add rotation on x and y axis
public func rotate(by angle: Float) -> Mat4x4 {
    let matrix = float4x4(
        [ cos(angle), sin(angle), 0, 0],
        [-sin(angle), cos(angle), 0, 0],
        [          0,          0, 1, 0],
        [          0,          0, 0, 1]
    )
    return matrix
}

public func translate(to translation: Vec3) -> Mat4x4 {
    let matrix = float4x4(
        [            1,             0,             0, 0],
        [            0,             1,             0, 0],
        [            0,             0,             1, 0],
        [translation.x, translation.y, translation.z, 1]
    )
    return matrix
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
