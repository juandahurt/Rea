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
    case orthogonal, perspective
}

public class Camera {
    public var position: Vec3 = .zero
    public var size: Float = 10
    public var clippingPlanes: (near: Float, far: Float) = (0.1, 100)
    public var projection: CameraProjection = .perspective
    public var fov: Float = 45
    
    init() {}
    
    func getProjectionMatrix(forSize viewSize: CGSize) -> Mat4x4 {
        let aspect = Float(viewSize.width / viewSize.height)
        switch projection {
        case .orthogonal:
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
        case .perspective:
            return ReaMath.projection(
                projectionFov: (fov / 180) * .pi,
                near: clippingPlanes.near,
                far: clippingPlanes.far,
                aspect: aspect
            )
        }
    }
    
    func getViewMatrix() -> Mat4x4 {
        switch projection {
        case .orthogonal:
            return translate(to: position)
        case .perspective:
            return lookAt(eye: position, center: [0, 0, 0], up: [0, 1, 0])
        }
    }
}
