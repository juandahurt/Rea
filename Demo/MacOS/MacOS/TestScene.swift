//
//  TestScene.swift
//  MacOS
//
//  Created by Juan David Hurtado on 15/11/24.
//

import Rea
import ReaCore

class TestScene: Scene {
    var player: Entity!
    var player2: Entity!
    
    var scale: Float = 10
    
    var t: Float = 0
    
    var velocityUp = Vec3(0, 0, 15)
    var velocityDown = Vec3(0, 0, -15)
    var velocityLeft = Vec3(-15, 0, 0)
    var velocityRight = Vec3(15, 0, 0)
    
    enum Dir { case up, down, left, right }
    var dirs: [Dir: Bool] = [
        .up: false,
        .down: false,
        .left: false,
        .right: false
    ]
    
    override init() {
        super.init()
        player = makeEntity()
        player2 = makeEntity()
    
        camera.clippingPlanes.far = 200
        camera.position = [0, 10, -150]
        
        let renderableComponent = player.getComponent(RenderableComponent.self)
        renderableComponent.setMesh(fileName: "teapot", ext: "usdz")
        
        let renderableComponent2 = player2.getComponent(RenderableComponent.self)
        renderableComponent2.setMesh(fileName: "train", ext: "usdz")
        
        let transform = player2.getComponent(TransformComponent.self)
        transform.position.x = -20
        transform.scale = 20
    }
    
    override func update(deltaTime: Float) {
//        let transform: TransformComponent = player.getComponent(TransformComponent.self)
//        transform.rotation.y = t
//        transform.scale = 2
//        
//        t += 0.01
//        
        applyVelocity(deltaTime)
    }
    
    override func keyDown(_ key: Key) {
        if key.code == .w {
            dirs[.up] = true
        }
        if key.code == .a {
            dirs[.left] = true
        }
        if key.code == .s {
            dirs[.down] = true
        }
        if key.code == .d {
            dirs[.right] = true
        }
    }
    
    override func keyUp(_ key: Key) {
        if key.code == .w {
            dirs[.up] = false
        }
        if key.code == .a {
            dirs[.left] = false
        }
        if key.code == .s {
            dirs[.down] = false
        }
        if key.code == .d {
            dirs[.right] = false
        }
    }
    
    override func mouseDown(at location: Vec2) {
        camera.fov += 5
//        let e = makeEntity()
//        let transform = e.getComponent(TransformComponent.self)
////        transform.rotation.x = .random(in: 0...45)
////        transform.scale = 12
//        
//        e.getComponent(RenderableComponent.self).setMesh(fileName: "train", ext: "usdz")
    }
}


extension TestScene {
    func applyVelocity(_ deltaTime: Float) {
        let transfom: TransformComponent = player.getComponent(TransformComponent.self)
        for (key, value) in dirs {
            if key == .up && value {
                camera.position += velocityUp * deltaTime
            }
            if key == .down && value {
                camera.position += velocityDown * deltaTime
            }
            if key == .left && value {
                transfom.position += velocityLeft * deltaTime
            }
            if key == .right && value {
                transfom.position += velocityRight * deltaTime
            }
        }
    }
}
