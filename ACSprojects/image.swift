//
//  image.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 25.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class image: UIViewController {
    @IBOutlet var uimage: UIImageView!
    var label: String?
    var link:String?
  //  @IBOutlet var label: UILabel!
    var textOfLabel: String = ""
    var linkoflink: String = "2"
    var web = ""
    @IBAction func web(_ sender: AnyObject) {
        if let requestUrl = URL(string: web) {
            UIApplication.shared.openURL(requestUrl)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        label = textOfLabel
        web = linkoflink
        
        let url = URL(string: label!)
        
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url!, completionHandler: {
            
            (url: URL?, res: URLResponse?, e: NSError?) in
            
            let d = try? Data(contentsOf: url!)
            
            let image = UIImage(data: d!)
            
            
            
            DispatchQueue.main.async {
                
               self.uimage.image = image
                
            }
            
        } as! (URL?, URLResponse?, Error?) -> Void)                    


        
        task.resume()
        
        

        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    
    
@IBOutlet var tableView: UITableView!
}
