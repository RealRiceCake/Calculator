//
//  ViewController.swift
//  Calculator
//
//  Created by Xiaohang Lv on 10/18/17.
//  Copyright © 2017 Xiaohang Lv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleTyping {
            let textCurrentInDisplay = display.text!
            display.text = textCurrentInDisplay + digit
        }
        else {
            display.text! = digit
            userIsInMiddleTyping = true
        }
        
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInMiddleTyping {
            brain.setOperand(displayValue)
            userIsInMiddleTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
}

