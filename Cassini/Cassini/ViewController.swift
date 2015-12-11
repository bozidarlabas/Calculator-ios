//
//  ViewController.swift
//  Cassini
//
//  Created by Bozidar on 11.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if we are going to imageViewController (3 buttons elads to ivController)
        if let ivController = segue.destinationViewController as? ImageViewController{
            if let identifier = segue.identifier{
                switch identifier{
                    case "Earth":
                        ivController.imageURL = DemoURL.NASA.Earth
                        ivController.title = "Earth"
                    case "Saturn":
                        ivController.imageURL = DemoURL.NASA.Saturn
                        ivController.title = "Saturn"
                case "Cassini":
                    ivController.imageURL = DemoURL.NASA.Cassini
                    ivController.title = "Cassini"
                default: break
                }
            }
        }
    }

}

