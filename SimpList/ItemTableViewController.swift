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
    
    var sections: [Section] = SectionsData().getSectionsFromData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
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
            print("This default case is actually impossible based on the code in Item.swift")
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    // first if statement that worked--with the edit location bug...
    //    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
    //        if let sourceViewController = sender.source as? ItemViewController, let item = sourceViewController.item {
    //            if let selectedIndexPath = tableView.indexPathForSelectedRow {
    //                // Update an existing item.
    //            sections[selectedIndexPath.section].items[selectedIndexPath.row] = item
    //            tableView.reloadRows(at: [selectedIndexPath], with: .none)
    //        }
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
        }
    }
}

 
 /*
 
 // I DON'T NEED THESE RIGHT NOW, keeping these duplicates separated in case I need to add them in for other functionality...
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 /*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */
 
 /*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

 */






/* KEEPING A COPY FOR REFERENCE IN CASE SOMETHING DOESN'T WORK...
 
    //MARK: Properties
    var items = [Item]()
 
 

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Use the edit button item prvided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
 
        // Load the initial data.
        loadInitialItems()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
 
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // I'll be updating this when I implement more than one table section <<<<<<<<<<<
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // I'll be updating this, too <<<<<<<<<<
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        // Table view cells are reused and will be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        // Fetches the appropriate item and quantityImage for the data source layout.
        let qty1 = UIImage(named: "qty1")
        let qty2 = UIImage(named: "qty2")
        let qty3 = UIImage(named: "qty3")
        let qty4 = UIImage(named: "qty4")
        let qty5 = UIImage(named: "qty5")
        let qty6 = UIImage(named: "qty6")
        
        let item = items[indexPath.row]
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
            print("This default case is actually impossible based on the code in Item.swift")
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
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    
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
            let selectedItem = items[indexPath.row]
            itemDetailViewController.item = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    
    
    //MARK: Actions
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ItemViewController, let item = sourceViewController.item {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new item.
                let newIndexPath = IndexPath(row: items.count, section: 0) // will need to update this section once implementing different locations.
            
                items.append(item)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    
    
    //MARK: Private Methods
    private func loadInitialItems() {
        guard let item1 = Item(name: "sweet italian creamer", quantity: 1, location: "1") else {
            fatalError("Unable to instantiate item1")
        }
        guard let item2 = Item(name: "juice", quantity: 2, location: "1") else {
            fatalError("Unable to instantiate item2")
        }
        guard let item3 = Item(name: "sour cream", quantity: 3, location: "1") else {
            fatalError("Unable to instantiate item3")
        }
        guard let item4 = Item(name: "top ramen", quantity: 4, location: "1") else {
            fatalError("Unable to instantiate item4")
        }
        guard let item5 = Item(name: "yogurt", quantity: 5, location: "1") else {
            fatalError("Unable to instantiate item5")
        }
        guard let item6 = Item(name: "hormel snacks", quantity: 6, location: "1") else {
            fatalError("Unable to instantiate item6")
        }
        
        items += [item1, item2, item3, item4, item5, item6]
    }

*/










