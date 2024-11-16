//
//  Shaders.metal
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

#import "../../../Shared/include/Shared.h"

#import <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    half4 color;
};

vertex VertexOut vertex_function(Vertex vert [[stage_in]]) {
    return { .position = float4(vert.position, 1), .color = half4(vert.color) };
}

fragment half4 fragment_function(VertexOut out [[stage_in]]) {
    return out.color;
}
