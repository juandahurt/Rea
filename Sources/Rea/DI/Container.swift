//
//  Container.swift
//  Rea
//
//  Created by Juan David Hurtado on 22/11/24.
//

@MainActor
class Container {
    private typealias Key = UInt8
    
    // I don't think this will be accessed like many times, so
    // maybe using a dict to store the instances isn't that bad.
    // Now, by using Any as value, I'm not sure how that can affect
    // the size of the variable in memory
    private var _instances: [Key: Any] = [:]
    
    private var _currentId: Key = 0
    
    private static let _instance = Container()
    
    private init() {}
    
    // MARK: - Register
    static func register<Instance>(_ factory: (Container) -> Instance) {
        _instance.register(factory)
    }
    
    func register<Instance>(_ factory: (Container) -> Instance) {
        _instances[_currentId] = factory(self)
        _currentId += 1
    }
    
    // MARK: - Retreive
    static func retreive<Instance>(_ type: Instance.Type) -> Instance {
        _instance.retreive(type)
    }
    
    func retreive<Instance>(_ type: Instance.Type) -> Instance {
        for index in 0..<_currentId {
            if let _instance = _instances[index] as? Instance {
                return _instance
            }
        }
        fatalError("instance of type \(type) not found!")
    }
}
