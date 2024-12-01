//
//  MemoryPool.swift
//  Rea
//
//  Created by Juan Hurtado on 29/11/24.
//

// TODO: add `removeEntity` method

class MemoryPool {
    let maxNumEntities = Settings.maxNumEntities
    var pool: (
        transform: UnsafeMutableBufferPointer<TransformComponent>,
        renderable: UnsafeMutableBufferPointer<RenderableComponent>
    )
    /// indicate if an entity is active or not
    var activeIndicators: UnsafeMutableBufferPointer<Bool>
    
    @MainActor
    private static let _instance = MemoryPool()
    
    init() {
        pool.transform = .allocate(capacity: maxNumEntities) { TransformComponent() }
        pool.renderable = .allocate(capacity: maxNumEntities) { RenderableComponent() }
        
        activeIndicators = .allocate(capacity: maxNumEntities) { false }
    }
    
    deinit {
        pool.transform.deallocate()
        pool.renderable.deallocate()
        activeIndicators.deallocate()
    }
    
    func findNextIndex() -> Int? {
        for index in 0..<maxNumEntities {
            if !activeIndicators[index] { return index }
        }
        return nil
    }
    
    @MainActor
    static func makeEntityID() -> Int {
        guard let index = _instance.findNextIndex() else {
            // TODO: handle error when user needs more entities than maxNumEntities
            fatalError("no memory available for new entity")
        }
        _instance.activeIndicators[index] = true
        return index
    }
    
    @MainActor
    static func getComponent<T: Component>(_ component: T.Type, ofEntityAt index: Int) -> T {
        if component is TransformComponent.Type {
            return _instance.pool.transform[index] as! T
        }
        if component is RenderableComponent.Type {
            return _instance.pool.renderable[index] as! T
        }
        fatalError("?")
    }
}
