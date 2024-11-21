//
//  InputSystem.swift
//  Rea
//
//  Created by Juan David Hurtado on 18/11/24.
//

import ReaCore

@MainActor
public class Input {
    #if os(macOS)
    var mouseEventHandler: MouseEventHandler?
    #endif
    
    init() {}
}

@MainActor
public protocol MouseEventHandler: AnyObject {
    func mouseMoved(at location: Vec2)
    func mouseDown(at location: Vec2)
}
