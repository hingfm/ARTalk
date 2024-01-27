//
//  simd_float3+Extensions.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import simd
import SceneKit

extension simd_float3
{
    public init(_ vector: SCNVector3) {
        self.init(x: vector.x, y: vector.y, z: vector.z)
    }

    public var magnitude: Float {
        get { return simd_length(self) }
    }

    public static func distance(_ from: Vector3, _ to: Vector3) -> Float {
        return (to - from).magnitude
    }
}
