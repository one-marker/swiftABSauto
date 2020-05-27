//
//  download.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 23.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class download: UIViewController {
    @IBOutlet var imageView: UIImageView!
 //   let imageCache = NSCache()
    @IBOutlet var label: UILabel!
    var s=""
    var array:[String]=[]

    @IBAction func but(_ sender: AnyObject) {
       // var urlString = "http://absauto.ru/desktop/search/?SEARCH=03C115561H%0D%0A&CROSS=1"
//var url = NSURL(string: urlString)!
       // var data = NSData(contentsOfURL: url)!
      /// imageView.image = UIImage(data: data)
        
        //imageView.image=image
        
        self.view.addSubview(imageView)
        
        
        
        
        let url = URL(string: s)
        
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url!, completionHandler: {
            
            (url: URL?, res: URLResponse?, e: NSError?) in
            
            let d = try? Data(contentsOf: url!)
            
            let image = UIImage(data: d!)
            
            
            
            DispatchQueue.main.async {
                
                self.imageView.image = image
                
            }
            
        } as! (URL?, URLResponse?, Error?) -> Void)                    


        
        task.resume()

        
        
           }
//
    override func viewDidAppear(_ animated: Bool) {
        
        

    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
                self.view.addSubview(imageView)
        
        let rootref = Database.database().reference()
        
        let cond = rootref.child("modeling")
        cond.observe(.childAdded,with:  { (snap: DataSnapshot) in
            
            if let dictionary = snap.value as? [String: AnyObject] {
                let add = ADD()
                //var link = ""
                 //  self.array.setValuesForKeysWithDictionary(dictionary)
              //add.setValuesForKeysWithDictionary(dictionary)
                //self.label.text = self.s
                //array.append(snap)
               // print(self.s)
               // print(snap)
               self.array.append(String(describing: dictionary))
                //print(arr)
              //  print(self.array)
                
                //
                
                
                
                
                
            }
            }, withCancel: nil)

        
        
        
      //  override func prepareforsegau
        
        //imageView.backgroundColor = UIColor.orangeColor()
 
    
            
    
}
}

