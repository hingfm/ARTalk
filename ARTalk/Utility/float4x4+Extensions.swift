//
//  float4x4+Extensions.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import simd

extension float4x4 {
    init(translation vector: SIMD3<Float>) {
        self.init(SIMD4<Float>(1, 0, 0, 0),
                  SIMD4<Float>(0, 1, 0, 0),
                  SIMD4<Float>(0, 0, 1, 0),
                  SIMD4<Float>(vector.x, vector.y, vector.z, 1))
    }
}
