//
//  Entity.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import ARKit
import JavaScriptCore

@objc public protocol EntityJSExports: JSExport {
    var name: String { get set }
}

@objc public class Entity: NSObject, EntityJSExports {
    public dynamic var name: String

    public lazy var position: Vector3 = {
        Vector3(x: 0, y: 0, z: 0)
    }()

    public lazy var euler: Vector3 = {
        Vector3(x: 0, y: 0, z: 0)
    }()

    public lazy var scale: Vector3 = {
        Vector3(x: 1, y: 1, z: 1)
    }()

    public var node: SCNNode {
        get { return _node }
    }
    
    private let _node: SCNNode
    
    public init(name: String, node: SCNNode, scene: SCNScene) {
        self.name = name
        self._node = node
        
        super.init()
        
        scene.rootNode.addChildNode(node)
    }
    
    deinit {
        _node.removeFromParentNode()
    }
    
    public func onUpdateFrame(deltaTime: TimeInterval, object: JSValue) {
        // Call JavaScript onUpdate
        object.invokeMethod("onUpdate", withArguments: [ deltaTime ])

        // Copy over JavaScript properties
        updateProperties(from: object)

        // Apply transform-related properties to node
        let deg2Rad: Float = .pi / 180
        _node.simdPosition = position
        _node.simdScale = scale
        _node.simdEulerAngles = euler * deg2Rad
    }

    private func updateProperties(from object: JSValue) {
        // Define the properties on the JS object if they don't exist initially
        if !object.hasProperty("position") {
            object.setValue([position.x, position.y, position.z], forProperty: "position" as NSString)
        }
        if !object.hasProperty("euler") {
            object.setValue([euler.x, euler.y, euler.z], forProperty: "euler" as NSString)
        }
        if !object.hasProperty("scale") {
            object.setValue([scale.x, scale.y, scale.z], forProperty: "scale" as NSString)
        }

        // Update our local properties from the JS object
        updateVector3(at: \Entity.position, named: "position", from: object)
        updateVector3(at: \Entity.euler, named: "euler", from: object)
        updateVector3(at: \Entity.scale, named: "scale", from: object)
    }
    
    private func updateVector3(at keyPath: ReferenceWritableKeyPath<Entity, Vector3>, named name: String, from object: JSValue) {
        if let property = object.forProperty(name), let values = property.toArray(), values.count >= 3 {
            if let x = values[0] as? NSNumber {
                self[keyPath: keyPath].x = x.floatValue
            }
            if let y = values[1] as? NSNumber {
                self[keyPath: keyPath].y = y.floatValue
            }
            if let z = values[2] as? NSNumber {
                self[keyPath: keyPath].z = z.floatValue
            }
        }
    }
}
