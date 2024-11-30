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
        let transformPointer: UnsafeMutablePointer<TransformComponent> = .allocate(
            capacity: maxNumEntities
        )
        let transformBuffer = UnsafeMutableBufferPointer(
            start: transformPointer,
            count: maxNumEntities
        )
        transformBuffer.initialize(fromContentsOf: transforms)
        pool.transform = transformBuffer
        
        var renderables: [RenderableComponent] = []
        renderables
            .append(contentsOf: (0..<maxNumEntities).map { _ in RenderableComponent() })
        let renderablePointer: UnsafeMutablePointer<RenderableComponent> = .allocate(
            capacity: maxNumEntities
        )
        let renderableBuffer = UnsafeMutableBufferPointer(
            start: renderablePointer,
            count: maxNumEntities
        )
        renderableBuffer.initialize(fromContentsOf: renderables)
        pool.renderable = renderableBuffer
        
        let flagsPointer: UnsafeMutablePointer<Bool> = .allocate(capacity: maxNumEntities)
        activeFlags = UnsafeMutableBufferPointer(start: flagsPointer, count: maxNumEntities)
    }
    
    deinit {
        print("deinit")
        pool.transform.deallocate()
        pool.renderable.deallocate()
        activeFlags.deallocate()
    }
    
    @MainActor
    static func makeEntityID() -> Int {
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
