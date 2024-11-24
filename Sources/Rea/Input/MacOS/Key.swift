//
//  Key.swift
//  Rea
//
//  Created by Juan David Hurtado on 20/11/24.
//

#if os(macOS)
import Foundation

// I wanted this to be an enum, but in the event handler methods,
// in order for them to be overriden, they need to be marked with
// @objc aaaaand enums cannot be represented in Obj-C (TIL)
@MainActor // dios mio librame de otro MainActor, no mas por favor
public class Key: NSObject {
    public var code: KeyCode
    
    init(code: KeyCode) {
        self.code = code
    }
//    
//    static let a: Key = .init(code: 0x00)
//    static let s: Key = .init(code: 0x01)
//    static let d: Key = .init(code: 0x02)
//    static let w: Key = .init(code: 0x0D)
}

public enum KeyCode: UInt16 {
    case a = 0x00
    case s = 0x01
    case d = 0x02
    case w = 0x0D
}
#endif
