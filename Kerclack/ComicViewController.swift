//
//  ComicViewController.swift
//  Kerclack
//
//  Created by Kyle Brooks Robinson on 6/27/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit
import AmazonS3RequestManager
import AFNetworking
import AFAmazonS3Manager

class ComicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var myImage: UIImage!
    
    var resizedImage: UIImage?
    
    var newComicItem: UIImageView?
    
    var fxBubbles = []
    var weapons = []
    var masks = []
    var otherItems = []
    var soundEffects = []
    
    var comicItems: [[String:AnyObject]] = []
    
    var imageAssetsArray: [UIImage] = []
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var itemCollectionOutlet: ItemCollectionView!
    
    @IBOutlet weak var newlyChosenPhoto: UIImageView!
    
    func generateImages() {
        
        for item in 0..<13 {
            
            imageAssetsArray.append(UIImage(named: "\(item)")!)

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateImages()
        println("\(imageAssetsArray)")
        
        myImageView.contentMode = UIViewContentMode.ScaleAspectFit
        myImageView.backgroundColor = UIColor.blackColor()
        
        newlyChosenPhoto.image = myImage
        
//        println(myUsername)
        
//        println(RailsRequest.session().token)
        
        // Pinch Gesture.  Might need to move from viewDidLoad.
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: "resizeMask:")
        view.addGestureRecognizer(pinchGesture)
        
        bottomConstraint.constant = -200
        
        
        itemCollectionOutlet.dataSource = self
        itemCollectionOutlet.delegate = self 

        
    }
    
    
    func resizeMask(gr: UIPinchGestureRecognizer) {
        
        if let currentMask = currentMask {
            
            let width = currentMask.frame.width
            let height = currentMask.frame.height
            
            //            let scale = 1.0 - ((1.0 - gr.scale) / 2)
            
            currentMask.frame.size.height = height + gr.velocity
            currentMask.frame.size.width = width + gr.velocity
            
            
        }

        
    }
    
    var currentMask: UIImageView?
    
    func addNewMask() {
        
        var newMaskView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        newMaskView.image = UIImage(named: "Mask")
        newMaskView.center = view.center
        
        view.addSubview(newMaskView)
        
        currentMask = newMaskView
        
    }
    
//    func imageResize() {
//        
//        var newSize = CGSize(width: 480,height: 640)
//        let rect = CGRectMake(0,0, newSize.width, newSize.height)
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        
//        // image is a variable of type UIImage
//        myImage?.drawInRect(rect)
//        
//        self.resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//                
//    }
    
    var startTouchLocation: CGPoint!
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if touches.count > 1 { return } // Don't move image if more than one touch.
        
        if let touch = touches.first as? UITouch {
            
            startTouchLocation = touch.locationInView(view)
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if touches.count > 1 { return } // Don't move image if more than one touch.
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(view)
            
            let distance = CGPointMake(location.x - startTouchLocation.x, location.y - startTouchLocation.y)
            
            if let currentMask = currentMask {
                
                currentMask.center = CGPointMake(currentMask.center.x + distance.x, currentMask.center.y + distance.y)
                
            }
            
            startTouchLocation = location
            
        }
        
    }
    
    @IBAction func imagesPressed(sender: AnyObject) {
        
    }
    
    
    @IBAction func soundsPressed(sender: AnyObject) {
    
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ItemCell
        
        if let selectedCell = cell.itemView {
            
            newComicItem = UIImageView(frame: CGRectMake(0, 0, 200, 200))
            
            newComicItem!.image = UIImage(named: "\(indexPath.row)")
            newComicItem!.center = view.center
            
            view.addSubview(newComicItem!)
            
            currentMask = newComicItem!
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
        
        cell.itemView.image = imageAssetsArray[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // This should return the count of the category of assets.

        return 12
        
        //        return imageAssetsArray.count
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        // This pops to the next VC.
        let finishVC = storyboard?.instantiateViewControllerWithIdentifier("finishVC") as! FinishViewController

        presentViewController(finishVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func undoButtonPressed(sender: AnyObject) {
        
        if comicItems.count > 0 {
            
            comicItems.removeLast()
            
        }
        
    }
    
    @IBAction func colorButtonPress(sender: AnyObject) {
    
        bottomConstraint.constant = (bottomConstraint.constant == 0) ? -200 : 0
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in })

    
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
