//
//  Camera.swift
//  Rea
//
//  Created by Juan David Hurtado on 24/11/24.
//

import CoreGraphics
import ReaCore
import ReaMath

public enum CameraProjection {
    case orthogonal // TODO: add perspective
}

public class Camera {
    public var position: Vec3 = .zero
    public var size: Float = 10
    public var clippingPlanes: (near: Float, far: Float) = (0, 10)
    public var projection: CameraProjection = .orthogonal
    
    init() {}
    
    func getProjectionMatrix(forSize viewSize: CGSize) -> Mat4x4 {
        let aspect = Float(viewSize.width / viewSize.height)
        return ortho(
            CGRect(
                x: CGFloat(-size * aspect * 0.5),
                y: .init(size * 0.5),
                width: .init(size * aspect),
                height: .init(size)
            ),
            near: clippingPlanes.near,
            far: clippingPlanes.far
        )
    }
    
    func getViewMatrix() -> Mat4x4 {
        translate(to: position)
    }
}
