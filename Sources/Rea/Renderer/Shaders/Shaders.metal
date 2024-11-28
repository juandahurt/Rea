//
//  Shaders.metal
//  Rea
//
//  Created by Juan Hurtado on 12/11/24.
//

#import "../../../ReaCore/include/ReaCore.h"

#import <metal_stdlib>
using namespace metal;

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

//vertex VertexOut vertex_function(Vertex vert [[stage_in]], constant Uniforms& uniforms [[buffer(10)]]) {
//    return {
//        .position = uniforms.projection * uniforms.view * uniforms.model * float4(vert.position, 1),
//        .color = half4(vert.color)
//    };
//}

fragment half4 fragment_function(VertexOut out [[stage_in]]) {
    return out.color;
}
