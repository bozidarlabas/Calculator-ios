//
//  ImageViewController.swift
//  Cassini
//
//  Created by Bozidar on 11.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: NSURL?{
        didSet{
            image = nil
            if view.window != nil{
                fetchImage()
            }
            
        }
    }
    
    private func fetchImage(){
        if let url = imageURL{
            let imageData = NSData(contentsOfURL: url) //NSData is bag of bits, reach out internet and grab bag of bits
            if imageData != nil{
                image = UIImage(data: imageData!)
            }else{
                image = nil
            }
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage?{
        get{return imageView.image}
        set{
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil{
            fetchImage()
        }
    }
    
}
