//
//  Item.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/11/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit
import os.log

class Item: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var quantity: Int
    var location: String
    

    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let quantity = "quantity"
        static let location = "location"
    }
        
        
        
    //MARK: Initialization
    init?(name: String, quantity: Int, location: String) {
        
        // Initialization will fail if there is no name or location, or if the quantity is less than 1...
        if name.isEmpty || quantity < 1 || location.isEmpty  {
            return nil
        }
        
        // The name must not be empty:
        guard !name.isEmpty else {
            return nil
        }
        
        // The quantity must be between 1 and 6 inclusively:
        guard (quantity > 0) && (quantity < 7) else {
            return nil
        }
        
        // The location must not be empty:
        guard !location.isEmpty else {
            return nil
        }
        
        // Initialize stored properties...
        self.name = name
        self.quantity = quantity
        self.location = location
    }
    
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(quantity, forKey: PropertyKey.quantity)
        aCoder.encode(location, forKey: PropertyKey.location)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer will fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for the Item object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let quantity = aDecoder.decodeInteger(forKey: PropertyKey.quantity)
        
        // The location is required. If we cannot decode a location string, the initializer will fail.
        guard let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String else {
            os_log("Unable to decode the location for the Item object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, quantity: quantity, location: location)
    }
}
