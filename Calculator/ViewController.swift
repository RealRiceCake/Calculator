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
    

    @IBAction func performOperation(_ sender: UIButton) {
        userIsInMiddleTyping = false
        if let mathSymbol = sender.currentTitle {
            switch mathSymbol {
            case "π":
                display.text = String(Double.pi)
            case "√":
                let operand = Double(display.text!)!
                display.text! = String(sqrt(operand))
            default:
                break
            }
        }
    }
    
}

