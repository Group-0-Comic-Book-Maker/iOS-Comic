//
//  CameraViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import AFNetworking
import AFAmazonS3Manager

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePick = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePick.sourceType = UIImagePickerControllerSourceType.Camera
        imagePick.delegate = self
        imagePick.showsCameraControls = true
        self.view.addSubview(imagePick.view)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var chosenPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let comicVC = storyboard?.instantiateViewControllerWithIdentifier("comicVC") as! ComicViewController
        
        comicVC.myImage = chosenPhoto
        
//        self.navigationController?.pushViewController(comicVC, animated: true)
        
        presentViewController(comicVC, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
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
