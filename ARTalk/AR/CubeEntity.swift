//
//  CubeEntity.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import SceneKit

@objc public class CubeEntity: Entity {
    public init(name: String, scene: SCNScene) {
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        let node = SCNNode(geometry: box)
        super.init(name: name, node: node, scene: scene)
        scale = Vector3(x: 0.1, y: 0.1, z: 0.1)
    }
}
