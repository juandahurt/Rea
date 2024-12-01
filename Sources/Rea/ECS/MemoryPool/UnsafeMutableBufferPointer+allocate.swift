//
//  UnsafeMutableBufferPointer+allocate.swift
//  Rea
//
//  Created by Juan Hurtado on 1/12/24.
//

extension UnsafeMutableBufferPointer where Element: Component {
    static func allocate(
        capacity: Int,
        with values: [Element]
    ) -> UnsafeMutableBufferPointer<Element> {
        let pointer: UnsafeMutablePointer<Element> = .allocate(
            capacity: capacity
        )
        let buffer = UnsafeMutableBufferPointer(start: pointer, count: capacity)
        buffer.initialize(fromContentsOf: values)
        return buffer
    }
}
