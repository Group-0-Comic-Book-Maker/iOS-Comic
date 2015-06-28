//
//  SubmitViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func takeAnotherButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    
    }
    
    @IBAction func mainMenuButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = ""
        
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
