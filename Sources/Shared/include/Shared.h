#ifndef Shared_h
#define Shared_h

#import <simd/simd.h>

typedef struct {
    simd_float3 position    [[attribute(0)]];
    simd_float4 color       [[attribute(1)]];
} Vertex;

#endif /* Shared_h */
