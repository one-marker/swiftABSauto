//
//  WalkthroughViewController.swift
//  TouchID
//
//  Created by Duc Tran on 11/29/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

import UIKit

class WalkthroughViewController2: UIViewController
{
    
    // These IBOutlets are already connect for you. We'll configure these outlets later
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
   // @IBOutlet weak var nextButton: UIButton!
  //  @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: - Data model for each walkthrough screen
    var index = 0               // the current page index
    var headerText = ""
    var imageName = ""
    var descriptionText = ""
    
    // Just to make sure that the status bar is white - it depends on your preference
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    // 1 - Let's configure a walkthrough screen with the data model
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = headerText
        descriptionLabel.text = descriptionText
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        // customize the next and start button
      //  startButton.isHidden = (index == 3) ? false : true
       // nextButton.isHidden = (index == 3) ? true : false
        //startButton.layer.cornerRadius = 5.0
        //startButton.layer.masksToBounds = true
    }
    
    // 2-  if the user click the start button, we will just dismiss the page VC as we are displaying this PageVC via a modal segue
    
  //user clicks the next button, we'll show the next page view controller
    
    @IBAction func nextClicked(_ sender: AnyObject)
    {
        
        let pageViewController = try self.parent as! PageViewController2
        pageViewController.nextPageWithIndex(index)
        
    }
}

























