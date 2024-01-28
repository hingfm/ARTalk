//
//  Log.swift
//  ARTalk
//
//  Created by Hing Chung on 28/1/2024.
//

import Foundation
import CoreData

@objc(Log)
public class LogCoreData: NSManagedObject {
    
    @NSManaged public var log: String?
    @NSManaged public var timestamp: Date?
}
