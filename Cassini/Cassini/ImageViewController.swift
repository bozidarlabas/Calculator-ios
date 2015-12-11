//
//  ImageViewController.swift
//  Cassini
//
//  Created by Bozidar on 11.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: NSURL?{
        didSet{
            image = nil
            if view.window != nil{
                fetchImage()
            }
            
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
            //delegate of outlet
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    //method from scroll delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage(){
        if let url = imageURL{
            spinner?.startAnimating() //? is added if image is fetching before outlet is loaded
            let qualityOfService = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qualityOfService, 0), { () -> Void in
               
                let imageData = NSData(contentsOfURL: url) //NSData is bag of bits, reach out internet and grab bag of bits
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if url == self.imageURL{
                        if imageData != nil{
                            self.image = UIImage(data: imageData!)
                        }else{
                            self.image = nil
                        }
                    }
                    
                })
            })
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage?{
        get{return imageView.image}
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil{
            fetchImage()
        }
    }
    
}
