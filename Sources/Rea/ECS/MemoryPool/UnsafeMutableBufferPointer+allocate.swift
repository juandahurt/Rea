//
//  UnsafeMutableBufferPointer+allocate.swift
//  Rea
//
//  Created by Juan Hurtado on 1/12/24.
//

extension UnsafeMutableBufferPointer where Element: Component {
    static func allocate(
        capacity: Int,
        intializingWith closure: () -> Element
    ) -> UnsafeMutableBufferPointer<Element> {
        let values: [Element] = (0..<capacity).map { _ in closure() }
        let pointer: UnsafeMutablePointer<Element> = .allocate(
            capacity: capacity
        )
        let buffer = UnsafeMutableBufferPointer(start: pointer, count: capacity)
        buffer.initialize(fromContentsOf: values)
        return buffer
    }
}
