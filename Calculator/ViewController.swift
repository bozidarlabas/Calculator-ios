//
//  ViewController.swift
//  Calculator
//
//  Created by Bozidar on 05.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

//Controller controlls user interface
class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!

    //All properties needs to be initialized
    var userTyping = false
    
    //Instatiate Model
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        //let is constant
        let digit = sender.currentTitle!
        if userTyping{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userTyping = true
        }
               print("digit = \(digit)")
    }
    
    @IBAction func enter() {
        userTyping = false
        //Update display Value
        if let result =  brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    //HOMEWORK - making display value into optional
    
    //Method is called when user press x, /, + or -
    @IBAction func operate(sender: UIButton) {
        if(userTyping){
            enter();
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
  
    
//    func multiply
    func divide(op1 : Double, op2: Double) -> Double{
        return op1 / op2
    }
    
    //Computed property
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }set{
           display.text = "\(newValue)"
            userTyping = false
        }
    }
    @IBAction func onClickX(sender: AnyObject) {
        
    }
}

