//
//  LoginViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    @IBAction func finishedButtonPressed(sender: AnyObject) {
        
        if usernameField.text.isEmpty == false && passwordField.text.isEmpty == false {
            
            errorLabel.text = ""
            
            RailsRequest.session().username = usernameField.text
            RailsRequest.session().password = passwordField.text
            
            RailsRequest.session().login({ () -> Void in
                
                println("Login storyboard transition should perform now.")
                
                let mainMenuVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainMenuVC") as! MainMenuViewController
                
                self.navigationController?.pushViewController(mainMenuVC, animated: true)
                
            })
            
        } else {
            
            errorLabel.text = "Please ensure that all fields have been completed."
            
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
        
        //        self.emailField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.view.setNeedsUpdateConstraints()
            self.view.setNeedsLayout()
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size{
                
                self.bottomConstraint.constant = 20 + kbSize.height
                
            }
            
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.bottomConstraint.constant = 20
            
        }
        
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
