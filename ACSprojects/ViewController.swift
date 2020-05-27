//
//  ViewController.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 21.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var but: UIButton!
    @IBOutlet var Username: UITextField!
    @IBOutlet var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil
        {
            
            
            if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "tab") as? UITabBarController{
                self.present(pageViewController, animated: true, completion: nil)
                //  }
                
            }
        }
        
        
        
        // performSelector("exit", withObject: self,afterDelay: 1)
        but.layer.cornerRadius = 5.0
        but.layer.masksToBounds = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    @IBAction func instagram(_ sender: AnyObject) {
        
        let web =
        "https://www.instagram.com/absautoru/"
        //go to link
        
        if let requestUrl = URL(string: web) {
            UIApplication.shared.openURL(requestUrl)
        }
    }
    @IBAction func facebook(_ sender: AnyObject) {
        
        
        
        let web =  "https://www.facebook.com/groups/1784289945122814/members/"
        
        
        //go to link
        
        if let requestUrl = URL(string: web) {
            UIApplication.shared.openURL(requestUrl)
        }
    }
    
    
    @IBAction func YouTube(_ sender: AnyObject) {
        let web =
        "https://www.youtube.com/channel/UCkGfiGrjmb2V_5Vtw0_heZw"
        //go to link
        
        if let requestUrl = URL(string: web) {
            UIApplication.shared.openURL(requestUrl)
        }
        
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func anonim(_ sender: AnyObject) {
        
        //   let userDefaults = NSUserDefaults.standardUserDefaults()
        // // let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
        
        // if we haven't shown the walkthroughs, let's show them
        //   if !displayedWalkthrough {
        // instantiate neew PageVC via storyboard
        // if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
        //   self.presentViewController(pageViewController, animated: true, completion: nil)
        //       // }
        //    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func action(_ sender: AnyObject) {
        //login()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch!
        {
            view.endEditing(true)
            
        }
        super.touchesBegan(touches, with: event)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @IBAction func CreateAccount(_ sender: AnyObject) {
        
        Auth.auth().createUser(withEmail: Username.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil
            {
                
            }
            else
            {
                // print("User Created")
                //  self.login()
            }
        })
    }
    
    
    @IBOutlet var button: UIButton!
    
    func login()
    {
        Auth.auth().signIn(withEmail: Username.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil
            {
                // print("No")
            }
            else
            {
                //print("OK")
                // self.dismissViewControllerAnimated(true, completion: nil)
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "pr") as? protected {
                    self.present(pageViewController, animated: true, completion: nil)
                    // }
                }
                
                
            }
            
            
            //FirstView()
        })
        
    }
    
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // let destinationVC: protected = segue.destinationViewController as! protected
    
    // destinationVC.mail.text = Username.text!
    //}
    
}

