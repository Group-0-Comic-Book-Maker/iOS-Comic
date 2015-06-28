//
//  SubmitViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import AmazonS3RequestManager
import AFNetworking
import AFAmazonS3Manager

class SubmitViewController: UIViewController, UITextFieldDelegate {
    
//    @IBAction func mainMenuButton(sender: AnyObject) {
//        
//        let mainMenuVC = storyboard?.instantiateViewControllerWithIdentifier("mainMenu") as! MainMenuViewController
//        
//        presentViewController(mainMenuVC, animated: true, completion: nil)
//        
//        //        presentViewController(mainMenuVC, animated: true, completion: nil)
//        
//    }
//    
//    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var submitImageView: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var submitImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        submitImageView.image = submitImage
        submitImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
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
    
    @IBAction func savePanelButtonPressed(sender: AnyObject) {
    
        // Send the text of the Caption Text Field.
        
        
        let finishVC = storyboard?.instantiateViewControllerWithIdentifier("finishVC") as! FinishViewController
        
        presentViewController(finishVC, animated: true, completion: nil)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func saveImageToS3(image: UIImage) {
//        
//        s3Manager.requestSerializer.bucket = bucket
//        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion
        //        s3Manager.requestSerializer.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        
//        let timestamp = Int(NSDate().timeIntervalSince1970)
//        
//        let imageName = "\(username)_\(timestamp)"
//        
//        let imageData = UIImagePNGRepresentation(image)
//        
//        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
//            
//            println(imageName)
//            
//            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
//            
//            println(filePath)
//            
//            imageData.writeToFile(filePath, atomically: false)
//            
//            let fileURL = NSURL(fileURLWithPath: filePath)
//            
//            s3Manager.putObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
//                
//                let percentageWritten = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite) * 100.0)
//                
//                println("Uploaded \(percentageWritten)%")
//                
//                }, success: { (responseObject) -> Void in
//                    
//                    let info = responseObject as! AFAmazonS3ResponseObject
//                    
//                    self.newURL = info.URL.absoluteString
//                    
//                    RailsRequest.session().postImage(self.newURL, answer: self.answerField.text, completion: { () -> Void in
//                        
//                        
//                    })
//                    
//                    println("\(responseObject)")
//                    
//                }, failure: { (error) -> Void in
//                    
//                    println("\(error)")
//                    
//            })
//            
//        }
//        
//    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
