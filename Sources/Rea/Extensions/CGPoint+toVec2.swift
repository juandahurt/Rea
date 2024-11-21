//
//  CGPoint+toVec2.swift
//  Rea
//
//  Created by Juan David Hurtado on 21/11/24.
//

import CoreFoundation
import ReaCore

extension CGPoint {
    func toVec2() -> Vec2 {
       [Float(x), Float(y)]
    }
}
