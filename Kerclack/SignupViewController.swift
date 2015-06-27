//
//  SignupViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var registrationInfo: [String:String] = [:]
    
    var areFieldsCompleted: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //finisButtonPressed
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
    
        if emailTextField.text.isEmpty == false && usernameTextField.text.isEmpty == false && passwordTextField.text.isEmpty == false {
            
            errorLabel.text = ""
            
            RailsRequest.session().email = emailTextField.text
            RailsRequest.session().username = usernameTextField.text
            RailsRequest.session().password = passwordTextField.text
            
            RailsRequest.session().registerWithCompletion({ () -> Void in
                
                println("Theoretically, you just registered.")
                
            })
            
            
            let mainMenu = storyboard?.instantiateViewControllerWithIdentifier("mainMenu") as! MainMenuViewController
            
            self.navigationController?.pushViewController(mainMenu, animated: true)
            
        } else {
            
            errorLabel.text = "Please ensure that all fields have been completed."
            
        }
    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
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
