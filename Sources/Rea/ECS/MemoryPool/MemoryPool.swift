//
//  MemoryPool.swift
//  Rea
//
//  Created by Juan Hurtado on 29/11/24.
//

class MemoryPool {
    let maxNumEntities = Settings.maxNumEntities
    var pool: (
        transform: UnsafeMutableBufferPointer<TransformComponent>,
        renderable: UnsafeMutableBufferPointer<RenderableComponent>
    )
    // indicate if an entity is active or not
    var activeFlags: UnsafeMutableBufferPointer<Bool>
    
    var index = -1 // TODO: remove
    
    @MainActor
    private static let instance = MemoryPool()
    
    init() {
        var transforms: [TransformComponent] = []
        transforms
            .append(contentsOf: (0..<maxNumEntities).map { _ in TransformComponent() })
        pool.transform = .allocate(capacity: maxNumEntities, with: transforms)
        
        var renderables: [RenderableComponent] = []
        renderables
            .append(contentsOf: (0..<maxNumEntities).map { _ in RenderableComponent() })
        pool.renderable = .allocate(capacity: maxNumEntities, with: renderables)
        
        let flagsPointer: UnsafeMutablePointer<Bool> = .allocate(capacity: maxNumEntities)
        activeFlags = UnsafeMutableBufferPointer(start: flagsPointer, count: maxNumEntities)
    }
    
    deinit {
        pool.transform.deallocate()
        pool.renderable.deallocate()
        activeFlags.deallocate()
    }
    
    @MainActor
    static func makeEntityID() -> Int {
//        for i in
        // TODO: find nearest available index
        instance.index += 1
        return instance.index
    }
    
    @MainActor
    static func getComponent<T: Component>(_ component: T.Type, ofEntityAt index: Int) -> T {
        if component is TransformComponent.Type {
            return instance.pool.transform[index] as! T
        }
        if component is RenderableComponent.Type {
            return instance.pool.renderable[index] as! T
        }
        fatalError("?")
    }
}
