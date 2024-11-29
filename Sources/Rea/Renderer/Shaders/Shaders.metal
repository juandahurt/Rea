//
//  Shaders.metal
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

#import "../../../ReaCore/include/ReaCore.h"

#import <metal_stdlib>
using namespace metal;

typedef struct {
    Vec4 position [[attribute(0)]];
} Vertex;


struct VertexOut {
    float4 position [[position]];
    half4 color;
};

vertex VertexOut vertex_function(Vertex vert [[stage_in]], constant Uniforms& uniforms [[buffer(10)]]) {
    return {
        .position = uniforms.projection * uniforms.view * uniforms.model * vert.position,
        .color = half4(0, 0, 0, 1)
    };
}

fragment half4 fragment_function(VertexOut out [[stage_in]]) {
    return out.color;
}
