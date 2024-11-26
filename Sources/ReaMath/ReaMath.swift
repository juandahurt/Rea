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

public func rotateZ(by angle: Float) -> Mat4x4 {
    let matrix = float4x4(
        [ cos(angle), sin(angle), 0, 0],
        [-sin(angle), cos(angle), 0, 0],
        [          0,          0, 1, 0],
        [          0,          0, 0, 1]
    )
    return matrix
}

public func rotate(by angles: Vec3) -> Mat4x4 {
    let rotatedX = rotateX(by: angles.x)
    let rotatedY = rotateY(by: angles.y)
    let rotatedZ = rotateZ(by: angles.z)
    return rotatedX * rotatedY * rotatedZ
}

public func rotateX(by angle: Float) -> Mat4x4 {
    let matrix = float4x4(
        [1,           0,          0, 0],
        [0,  cos(angle), sin(angle), 0],
        [0, -sin(angle), cos(angle), 0],
        [0,           0,          0, 1]
    )
    return matrix
}
    
public func rotateY(by angle: Float) -> Mat4x4 {
    let matrix = float4x4(
        [cos(angle), 0, -sin(angle), 0],
        [         0, 1,           0, 0],
        [sin(angle), 0,  cos(angle), 0],
        [         0, 0,           0, 1]
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

public func lookAt(eye: Vec3, center: Vec3, up: Vec3) -> Mat4x4 {
    let z = normalize(center - eye)
    let x = normalize(cross(up, z))
    let y = cross(z, x)
    
    let X = float4(x.x, y.x, z.x, 0)
    let Y = float4(x.y, y.y, z.y, 0)
    let Z = float4(x.z, y.z, z.z, 0)
    let W = float4(-dot(x, eye), -dot(y, eye), -dot(z, eye), 1)
    
    return .init(columns:(X, Y, Z, W))
 }

public func projection(projectionFov fov: Float, near: Float, far: Float, aspect: Float, lhs: Bool = true) -> Mat4x4 {
    let y = 1 / tan(fov * 0.5)
    let x = y / aspect
    let z = lhs ? far / (far - near) : far / (near - far)
    let X = float4( x,  0,  0,  0)
    let Y = float4( 0,  y,  0,  0)
    let Z = lhs ? float4( 0,  0,  z, 1) : float4( 0,  0,  z, -1)
    let W = lhs ? float4( 0,  0,  z * -near,  0) : float4( 0,  0,  z * near,  0)
    return .init(columns: (X, Y, Z, W))
}
