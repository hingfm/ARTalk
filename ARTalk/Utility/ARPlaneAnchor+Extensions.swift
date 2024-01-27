//
//  ARPlaneAnchor+Extensions.swift
//  ARTalk
//
//  Created by Hing Chung on 21/1/2024.
//

import ARKit

@available(iOS 12.0, *)
extension ARPlaneAnchor.Classification {
    var description: String {
        switch self {
        case .wall:
            return "Wall"
        case .floor:
            return "Floor"
        case .ceiling:
            return "Ceiling"
        case .table:
            return "Table"
        case .seat:
            return "Seat"
        case .none(.unknown):
            return "Unknown"
        default:
            return ""
        }
    }
}
