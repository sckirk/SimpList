//
//  Item.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/11/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

class Item {
    
    //MARK: Properties
    var name: String
    var quantity: Int
    var location: String
    var photo: UIImage?
    
    
    
    //Initialization
    init?(name: String, quantity: Int, location: String, photo: UIImage?) {
        
        // Initialization should fail if there is no name or location, or if the quantity is less than 1.
        if name.isEmpty || quantity < 1 || location.isEmpty  {
            return nil
        }
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The quantity must be between 1 and 6 inclusively
        guard (quantity > 0) && (quantity < 7) else {
            return nil
        }
        
        // The location must not be empty
        guard !location.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.quantity = quantity
        self.location = location
    }
}
