//
//  Component.swift
//  Rea
//
//  Created by Juan David Hurtado on 15/11/24.
//

import ReaCore

public class Component {
    var isActive = false
}

public class TransformComponent: Component {
    public var position: Vec3 = .zero
}
