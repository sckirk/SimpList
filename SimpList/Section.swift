//
//  Section.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/16/17.
//  Copyright © 2017 SK. All rights reserved.
//

import Foundation
import os.log

class Section: NSObject, NSCoding {
    
    //MARK: Properties
    var heading : String
    var items = [Item]()
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("sections") // this sections part needs to be updated for this to work...
    
    
    
    //MARK: Types
    struct PropertyKey {
        static let heading = "heading"
        static let items = "items"
    }

    
    init(title: String, objects : [Item]) {
        heading = title
        items = objects
    }
    
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(heading, forKey: PropertyKey.heading)
        aCoder.encode(items, forKey: PropertyKey.items)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The heading is required. If we cannot decode a heading string, the initializer will fail.
        guard let heading = aDecoder.decodeObject(forKey: PropertyKey.heading) as? String else {
            os_log("Unable to decode the heading for the Section object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The location is required. If we cannot decode a location string, the initializer will fail.
        guard let items = aDecoder.decodeObject(forKey: PropertyKey.items) as? [Item] else {
            os_log("Unable to decode the items for the Section object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(title: heading, objects: items)
    }

}
