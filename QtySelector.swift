//
//  QtySelector.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/10/17.
//  Copyright © 2017 SK. All rights reserved.
//

//import UIKit
//
//@IBDesignable class QtySelector: UIStackView {
//    
//    //MARK: Properties
//    private var quantityButtons = [UIButton]()
//    
//    var quantity = 0 {
//        didSet {
//            updateButtonSelectionStates()
//        }
//    }
//
//    @IBInspectable var qtySize: CGSize = CGSize(width: 46.6, height: 46.6) {
//        didSet {
//            setupButtons()
//        }
//    }
//
//    @IBInspectable var qtyCount: Int = 6 {
//        didSet {
//            setupButtons()
//        }
//    }
//
//    
//    
//    //MARK: Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupButtons()
//    }
//    
//    required init(coder: NSCoder) {
//        super.init(coder: coder)
//        setupButtons()
//    }
//    
//    
//    
//    //MARK: Button Action
//    func quantityButtonTapped(button: UIButton) {
//        guard let index = quantityButtons.index(of: button) else {
//            fatalError("The button, \(button), is not in the quantityButtons array: \(quantityButtons)")
//        }
//        
//        // Calculate the quantity of the selected button
//        let selectedQuantity = index + 1
//       
//        if selectedQuantity == quantity {
//            // If the selected image represents the current quantity, reset the quantity to 0.
//            quantity = 0
//        } else {
//            // Otherwise set the quantity to the selected image
//            quantity = selectedQuantity
//        }
//    }
//
//    
//    
//    //MARK: Private Methods
//    private func setupButtons() {
//        
//        // clear any existing buttons
//        for button in quantityButtons {
//            removeArrangedSubview(button)
//            button.removeFromSuperview()
//        }
//        quantityButtons.removeAll()
//
//        // Load Button Images
//        let bundle = Bundle(for: type(of: self))
//        let filledKale = UIImage(named: "filledKale", in: bundle, compatibleWith: self.traitCollection)
//        let emptyKale = UIImage(named:"emptyKale", in: bundle, compatibleWith: self.traitCollection)
//        let highlightedKale = UIImage(named:"highlightedKale", in: bundle, compatibleWith: self.traitCollection)
//        
//        for index in 0..<qtyCount {
//            // Create the button
//            let button = UIButton()
//            
//            // Set the button images
//            button.setImage(emptyKale, for: .normal)
//            button.setImage(filledKale, for: .selected)
//            button.setImage(highlightedKale, for: .highlighted)
//            button.setImage(highlightedKale, for: [.highlighted, .selected])
//        
//            // Add constraints
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.heightAnchor.constraint(equalToConstant: qtySize.height).isActive = true
//            button.widthAnchor.constraint(equalToConstant: qtySize.width).isActive = true
//            
//            // Set the accessibility label
//            button.accessibilityLabel = "Set \(index + 1) quantity count"
//            
//            // Setup the button action
//            button.addTarget(self, action: #selector(QtySelector.quantityButtonTapped(button:)), for: .touchUpInside)
//            
//            // Add the button to the stack
//            addArrangedSubview(button)
//            
//            // Add the new button to the quantity button array
//            quantityButtons.append(button)
//        }
//        
//        updateButtonSelectionStates()
//        
//        // print(ratingButtons)    // trying to debug if/why I only have 1 button instead of 5. And now it WORKS?! Why? Maybe I hadn't hit save or something like that prior to my earlier build... Xcode.
//    }
//    
//    private func updateButtonSelectionStates() {
//        for (index, button) in quantityButtons.enumerated() {
//            // If the index of a button is less than the quantity selected, that button will be selected.
//            button.isSelected = index < quantity
//            
//            // Set the hint string for the currently selected image
//            let hintString: String?
//            if quantity == index + 1 {
//                hintString = "Tap to reset the quantity to zero."
//            } else {
//                hintString = nil
//            }
//            
//            // Calculate the value string
//            let valueString: String
//            switch (quantity) {
//            case 0:
//                valueString = "No quantity set."
//            case 1:
//                valueString = "1 quantity set."
//            default:
//                valueString = "\(quantity) quantities set."
//            }
//            
//            // Assign the hint string and value string
//            button.accessibilityHint = hintString
//            button.accessibilityValue = valueString
//        }
//    }
//
//
//   
//}
