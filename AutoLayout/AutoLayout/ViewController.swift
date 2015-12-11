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
    
    @IBOutlet weak var tvName: UILabel!
    
    @IBOutlet weak var tvCompany: UILabel!
    
    @IBOutlet weak var ivImage: UIImageView!
    
    var aspectRatioConstraint: NSLayoutConstraint?{
        willSet{
            if let existingConstraint = aspectRatioConstraint{
                view.removeConstraint(existingConstraint)
            }
        }
        didSet{
            if let newConstraint = aspectRatioConstraint{
                view.addConstraint(newConstraint)
            }
        }
    }
    
    var loggedInUser: User? {
        didSet{
            updateUI()
        }
    }
    
    var secure: Bool = false{
        didSet{
            updateUI()
        }
    }
    
    //This is called when view is loaded (outlets are already initialized)
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI(){
        etPassword.secureTextEntry = secure
        tvPassword.text = secure ? "Secured password" : "Password"
        tvName.text = loggedInUser?.name
        tvCompany.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(etUsername.text ?? "", password: etPassword.text ?? "")
    }
    
    //I use that because every time i use image i want update aspect ratio constraint
    var image: UIImage?{
        get{
            return ivImage.image
        }
        set{
            ivImage.image = newValue
            if let constrainedView = ivImage{
                if let newImage = newValue{
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                }else{
                    aspectRatioConstraint = nil
                }
            }
            
        }
        
    }
}

//Extending User model
extension User{
    var image: UIImage?{
        if let image =  UIImage(named: login){
            return image
        }else{
            return UIImage(named: "Unknown_user")
        }
    }
}

extension UIImage{
    var aspectRatio: CGFloat{
        return size.height != 0 ? size.width / size.height : 0
    }
}

