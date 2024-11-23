//
//  ReaWindow+macOSEvents.swift
//  Rea
//
//  Created by Juan David Hurtado on 19/11/24.
//

#if os(macOS)
import AppKit
import ReaCore

// MARK: - Mouse
// it'd be interesting to support the mouse entered and exited event,
// but since it needs a tracking view I'll leave that for later
extension ReaWindow {
    public override func mouseMoved(with event: NSEvent) {
        let location = event.locationInWindow.toVec2()
        input.mouseEventHandler?.mouseMoved(at: location)
    }
    
    public override func mouseDown(with event: NSEvent) {
        let location = event.locationInWindow.toVec2()
        input.mouseEventHandler?.mouseDown(at: location)
    }
}

// MARK: - Keyboard
extension ReaWindow {
    public override func keyDown(with event: NSEvent) {
        guard let keyCode = KeyCode(rawValue: event.keyCode) else {
            print("key not supported :c")
            return
        }
        let key = Key(code: keyCode)
        input.keyEventHandler?.keyDown(key)
    }
    
    public override func keyUp(with event: NSEvent) {
        guard let keyCode = KeyCode(rawValue: event.keyCode) else {
            print("key not supported :c")
            return
        }
        let key = Key(code: keyCode)
        input.keyEventHandler?.keyUp(key)
    }
}
#endif
