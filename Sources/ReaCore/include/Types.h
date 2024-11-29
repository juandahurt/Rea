//
//  Types.h
//  Rea
//
//  Created by Juan David Hurtado on 16/11/24.
//

#include <simd/simd.h>

typedef simd_float2 Vec2;
typedef simd_float3 Vec3;
typedef simd_float4 Vec4;

typedef simd_float4x4 Mat4x4;

typedef struct {
    Mat4x4 model;
    Mat4x4 view;
    Mat4x4 projection;
} Uniforms;
