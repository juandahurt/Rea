//
//  Input+NSEvent.swift
//  Rea
//
//  Created by Juan David Hurtado on 20/11/24.
//

#if os(macOS)
import AppKit

extension Input {
    func notify(_ event: NSEvent) {
        eventHandler?.handleInput(event: mapNSEventToEvent(event))
    }
    
    func mapNSEventToEvent(_ event: NSEvent) -> Event {
        switch event.type {
        case .mouseMoved:
            let location = event.locationInWindow
            mousePosition = [Float(location.x), Float(location.y)]
            return .mouse(.mouseMoved)
        case .mouseEntered:
            return .mouse(.mouseEntered)
        case .mouseExited:
            return .mouse(.mouseExited)
        case .keyDown:
            guard let key = Key(rawValue: event.keyCode) else {
                fatalError("key not supported, yet. :)")
            }
            return .key(.keyDown(key))
        default:
            fatalError("unreachable code")
        }
    }
}
#endif
