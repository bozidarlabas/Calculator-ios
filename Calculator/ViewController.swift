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
    var userTyping: Bool = false
    
    
    
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
}

