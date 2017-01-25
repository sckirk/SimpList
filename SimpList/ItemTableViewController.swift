//
//  ItemTableViewController.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/12/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit
import os.log


class ItemTableViewController: UITableViewController {
    
    var sections = [Section]()
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // var sections: [Section] = SectionsData().getSectionsFromData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling:
        self.tableView.backgroundColor = hexStringToUIColor(hex: "F5EEC7") // cream
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved sections, otherwise load default data...
        if let savedSections = loadSections() {
            sections += savedSections
            
            // This code checks to see if all of the sections have zero items. If that's the case, default data will be reloaded...
            var sectionsAllEmpty = true
            for sect in sections {
                if sect.items.count != 0 {
                    sectionsAllEmpty = false
                }
            }
            if sectionsAllEmpty == true {
                sections = SectionsData().getSectionsFromData()
            }
        } else {
            // Load the default data. This will happen the first time the app is loaded onto a new phone or the first time it's opened after being rebuilt on a device.
            sections = SectionsData().getSectionsFromData()
        }
    }
    
    // Table view color styling:
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = hexStringToUIColor(hex: "1E3446") // blue
        header.textLabel?.backgroundColor = hexStringToUIColor(hex: "F5EEC7") // cream
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }
    
    // SUZ-- IS THIS CURRENTLY DOING ANYTHING????? <<<<<<<<<<<<<<
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        let header :UITableViewHeaderFooterView = UITableViewHeaderFooterView()
        
        header.contentView.tintColor = UIColor(red: 30.0/255.0, green: 52.0/255.0, blue: 70.0/255.0, alpha: 1)
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and will be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        // Fetches the appropriate item name and quantityImage for the data source layout.
        let qty1 = UIImage(named: "qty1")
        let qty2 = UIImage(named: "qty2")
        let qty3 = UIImage(named: "qty3")
        let qty4 = UIImage(named: "qty4")
        let qty5 = UIImage(named: "qty5")
        let qty6 = UIImage(named: "qty6")
        
        let item = sections[indexPath.section].items[indexPath.row]
        cell.itemNameLabel.text = item.name
        
        switch (item.quantity)
        {
        case 1:
            cell.qtyImageView.image = qty1
            
        case 2:
            cell.qtyImageView.image = qty2
            
        case 3:
            cell.qtyImageView.image = qty3
            
        case 4:
            cell.qtyImageView.image = qty4
            
        case 5:
            cell.qtyImageView.image = qty5
            
        case 6:
            cell.qtyImageView.image = qty6
            
        default:
            print("This default case is actually impossible based on the code for the UI Stepper")
        }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sections[indexPath.section].items.remove(at: indexPath.row)
            saveSections()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new item.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let itemDetailViewController = segue.destination as? ItemViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedItemCell = sender as? ItemTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedItem = sections[indexPath.section].items[indexPath.row]
            itemDetailViewController.item = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

    
    
    //MARK: Actions
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ItemViewController, let item = sourceViewController.item {
            
            func addNewItem() {
                // creating a loop that iterates over sections and saves the section whose heading == item.location as a constant I'm using below:
                for sect in sections {
                    if sect.heading == item.location {
                        let thisSection = sect
                        
                        let newIndexPath = IndexPath(row: thisSection.items.count, section: sections.index{$0.heading == item.location}!)
                        
                        sections[sections.index{$0.heading == item.location}!].items.append(item)
                        tableView.insertRows(at: [newIndexPath], with: .automatic)
                    }
                }
            }
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item...
                    // if the item's location hasn't changed...
                if sections[selectedIndexPath.section].heading == item.location {
                    sections[selectedIndexPath.section].items[selectedIndexPath.row] = item
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
                else { // if the item's location has changed...
                    // first delete the item from its old location
                    sections[selectedIndexPath.section].items.remove(at: selectedIndexPath.row)
                    tableView.deleteRows(at: [selectedIndexPath], with: .fade)
                    // then add the item into its new location
                    addNewItem()
                }
            }
            else {
                // Add a new item...
                addNewItem()
            }
            
            // Save the sections:
            saveSections()
        }
    }
    
    
    
    //MARK: Private Methods
    private func saveSections() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(sections, toFile: Section.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Sections successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save sections...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadSections() -> [Section]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Section.ArchiveURL.path) as? [Section]
    }
}
