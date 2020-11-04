//
//  graph_shader.metal
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//
#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float value;
};

struct VertexOut {
    float4 position  [[position]];
    float  pointSize [[point_size]];
    float4 color;
};

struct Uniforms {
    uint32_t offset;
    uint32_t capacity;
    float    minValue;
    float    maxValue;
    uint8_t  pointSize;
    float4   topColor;
    float4   bottomColor;
};

vertex VertexOut vertexShader(device   VertexIn *vertices [[buffer(0)]],
                              constant Uniforms *uniforms [[buffer(1)]],
                              uint vid [[vertex_id]])
{
    // normalizedY is in the range [0, 1], where 0 is bottom, 1 is top
    float normalizedY = (vertices[vid].value - uniforms->minValue) / (uniforms->maxValue - uniforms->minValue);
    // transform normalizedY to the range [-1, 1]
    float y = normalizedY * 2.0f - 1.0f;
    
    // Use the offset and the vid to find the index. xIndex is in the range [0, uniforms->numSamples - 1]
    float xIndex = float((vid + (uniforms->capacity - uniforms->offset)) % uniforms->capacity);
    // Transforming xIndex to the range [-1, 1]
    float x = (xIndex / float(uniforms->capacity - 1)) * 2.0f - 1.0f;
    
    VertexOut vOut;
    vOut.pointSize = uniforms->pointSize;
    vOut.position = {x, y, 1.0f, 1.0f};
    vOut.color = mix(uniforms->bottomColor, uniforms->topColor, normalizedY);
    
    return vOut;
}

fragment float4 fragmentShader(VertexOut input [[stage_in]]) {
    return input.color;
}
