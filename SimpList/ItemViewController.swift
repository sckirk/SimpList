//
//  ItemViewController.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/9/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit
import os.log

class ItemViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Properties
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var qtyLabel: UILabel!
    @IBOutlet var qtyStepper: UIStepper!
    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    // This value is either passed by `ItemTableViewController` in `prepare(for:sender:)` or constructed as part of adding a new item.
    var item: Item?
    
    // location options array--immutable
    let pickOption = ["health/bath", "toys/garden/home", "kitchen/crafts", "right grocery", "back right refrigerated", "left grocery", "back left refrigerated", "clothes/shoes", "natural section", "organic produce", "frozen"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // qtyStepper code...
        qtyStepper.wraps = true
        qtyStepper.autorepeat = true
        qtyStepper.minimumValue = 1
        qtyStepper.maximumValue = 6
        
        
        // pickerView code...
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        pickerTextField.inputView = pickerView
        
        // create a "done" button on the UI picker...
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ItemViewController.donePressed))
        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.5, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "American Typewriter", size: 17)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "select store location"
        
        label.textAlignment = NSTextAlignment.left
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([textBtn,doneButton], animated: true)
//        toolBar.setItems([flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        pickerTextField.inputAccessoryView = toolBar

        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        
        // Set up views if editing an existing Item.
        if let item = item {
            navigationItem.title = item.name
            nameTextField.text = item.name
            qtyLabel.text = Int(item.quantity).description
            pickerTextField.text = item.location
            qtyStepper.value = Double(item.quantity)
        }
        
        
        // Enable the Save button only if the text field has a valid Item name and item location has been selected.
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func donePressed(_ sender: UIBarButtonItem) {
        pickerTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickOption[row]
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddItemMode = presentingViewController is UINavigationController
        
        if isPresentingInAddItemMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ItemViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let quantity = Int(qtyLabel.text!) ?? 1
        let location = pickerTextField.text ?? ""
        
        // Set the item to be passed to ItemTableViewController after the unwind segue.
        item = Item(name: name, quantity: quantity, location: location)
    }

    
    
    //MARK: Actions
    @IBAction func qtyStepperValueChanged(_ sender: UIStepper) {
        qtyLabel.text = Int(sender.value).description
    }
    
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
        // Disable the Save button if a location has not been selected.
        let text2 = pickerTextField.text ?? ""
        saveButton.isEnabled = !text2.isEmpty
    }


}

