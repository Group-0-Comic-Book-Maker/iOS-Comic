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
    
    var comicItems: [UIImageView] = []
    
    var itemViewCollection: [UIImageView] = []
    
    var imageAssetsArray: [UIImage] = []
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var itemCollectionOutlet: ItemCollectionView!
    
    func generateImages() {
        
        for item in 0..<26 {
            
            if var newItemImage = UIImage(named: "\(item)") {
                
                imageAssetsArray.append(newItemImage)
                
            }
    
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateImages()
        
        myImageView.contentMode = UIViewContentMode.ScaleAspectFit
        myImageView.backgroundColor = UIColor.blackColor()
        
        myImageView.image = myImage
        
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
            
            currentMask.frame.size.height = height + gr.velocity
            currentMask.frame.size.width = width + gr.velocity
            
        }

        
    }
    
    var currentMask: UIImageView?
    
    func addNewMask() {
        
        var newMaskView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        newMaskView.image = UIImage(named: "Mask")
        newMaskView.center = view.center
        
        myImageView.addSubview(newMaskView)
        comicItems.append(newMaskView)
        
        currentMask = newMaskView
        
    }
    
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
            newComicItem?.contentMode = .ScaleAspectFit
            newComicItem!.image = UIImage(named: "\(indexPath.row)")
            newComicItem!.center = view.center
            
            myImageView.addSubview(newComicItem!)
            itemViewCollection.append(newComicItem!)
            
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
        
            return imageAssetsArray.count
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        // This pops to the next VC.
        
        UIGraphicsBeginImageContext(self.myImageView.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        myImageView.layer.renderInContext(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let submitVC = storyboard?.instantiateViewControllerWithIdentifier("submitVC") as! SubmitViewController

        submitVC.submitImage = newImage
        
        self.navigationController?.pushViewController(submitVC, animated: true)
        
        
    }
    
    @IBAction func undoButtonPressed(sender: AnyObject) {
        
        if itemViewCollection != [] {
            
            itemViewCollection.last?.removeFromSuperview()
            itemViewCollection.removeLast()
            
        }
        
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        
        for item in itemViewCollection {
            
            item.removeFromSuperview()
            
        }
    
    }
    
    @IBAction func colorButtonPress(sender: AnyObject) {
    
        bottomConstraint.constant = (bottomConstraint.constant == 0) ? -200 : 0
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in })

    
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func mainMenuButtonPressed(sender: AnyObject) {
        
       dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
