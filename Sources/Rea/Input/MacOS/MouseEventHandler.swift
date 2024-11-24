//
//  MouseEventHandler.swift
//  Rea
//
//  Created by Juan David Hurtado on 22/11/24.
//

import ReaCore

@MainActor
public protocol MouseEventHandler: AnyObject {
    func mouseMoved(at location: Vec2)
    func mouseDown(at location: Vec2)
}
