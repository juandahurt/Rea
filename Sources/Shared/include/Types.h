//
//  Types.h
//  Rea
//
//  Created by Juan David Hurtado on 16/11/24.
//

#include <simd/simd.h>

typedef struct {
    simd_float3 position    [[attribute(0)]];
    simd_float4 color       [[attribute(1)]];
} Vertex;
