//
//  WelcomeViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func mainMenuPressed(sender: AnyObject) {
    
        let mainMenu = storyboard?.instantiateViewControllerWithIdentifier("mainMenuVC") as! MainMenuViewController
        
        self.navigationController?.pushViewController(mainMenu, animated: true)
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}