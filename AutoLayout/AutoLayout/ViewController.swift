//
//  ViewController.swift
//  AutoLayout
//
//  Created by Bozidar on 11.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var etUsername: UITextField!
    
    @IBOutlet weak var etPassword: UITextField!
    
    @IBOutlet weak var tvUsername: UILabel!
    
    @IBOutlet weak var tvPassword: UILabel!
    
    //This is called when view is loaded (outlets are already initialized)
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var secure: Bool = false{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        etPassword.secureTextEntry = secure
        tvPassword.text = secure ? "Secured password" : "Password"
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
}

