//
//  SCNNode+Extensions.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import SceneKit

extension SCNNode {
    func centerAlign() {
        let (min, max) = boundingBox
        let extents = SIMD3<Float>(max) - SIMD3<Float>(min)
        simdPivot = float4x4(translation: ((extents / 2) + SIMD3<Float>(min)))
    }
}
