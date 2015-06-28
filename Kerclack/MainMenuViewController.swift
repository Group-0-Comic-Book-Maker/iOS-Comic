//
//  MainMenuViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBAction func makePanelsButton(sender: AnyObject) {
    
        let cameraVC = storyboard?.instantiateViewControllerWithIdentifier("cameraVC") as! CameraViewController
        
        presentViewController(cameraVC, animated: true, completion: nil)
        
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
    
        RailsRequest.session().username = ""
        RailsRequest.session().password = ""
        RailsRequest.session().email = ""
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
