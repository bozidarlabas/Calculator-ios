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
    
    //var operandStack: Array<Double> = Array<Double>()
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userTyping = false
        operandStack.append(displayValue)
        print("Operand stack = \(operandStack)")
    }
    
    //Method is called when user press x, /, + or -
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if(userTyping){
            enter();
        }
        
        switch operation {
            case "×": performOperation{ $0 * $1 }
            case "÷": performOperation{ $1 / $0 }
            case "+": performOperation{ $0 + $1 }
            case "−": performOperation{ $1 - $0 }
            case "√": performSqrtOperation{ sqrt($0) }
            default: break
        }
    }
    
    //Parameter is function which takes two doubles and return Double
    func performOperation(operation: (Double, Double) -> Double){
        if(operandStack.count >= 2){
            //Calculate last two double from stack and remove them
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            //Add new value to stack
            enter()
        }
    }
    
    //Parameter is function which takes two doubles and return Double
    func performSqrtOperation(operation: Double -> Double){
        if(operandStack.count >= 1){
            //Calculate last two double from stack and remove them
            displayValue = operation(operandStack.removeLast())
            //Add new value to stack
            enter()
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
}

