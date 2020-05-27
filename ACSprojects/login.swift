//
//  login.swift
//  ABSauto
//
//  Created by Максим Евлентьев on 23.08.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//
//
//  ViewController.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 21.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase

class login: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var but: UIButton!
    @IBOutlet var Username: UITextField!
   
    @IBOutlet var key: UIImageView!
    @IBOutlet var Password: UITextField!
    @IBAction func nonekeyboard(_ sender: AnyObject) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      // textField.resignFirstResponder()
        
        if (textField == Username)
        {
            self.Password.becomeFirstResponder()
        }
        if (textField == Password)
        {
            self.login()
        }
        return false
    }
    @IBOutlet var scrolling: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.Username.becomeFirstResponder()
        but.layer.cornerRadius = 5.0
        //scrolling.contentSize.height=350
        but.layer.masksToBounds = true
        self.Username.delegate = self
        self.Password.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func action(_ sender: AnyObject) {
        login()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        do {
           print("Ll")
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        // Dispose of any resources that can be recreated.
    }
   
    @IBOutlet var scroll: UIScrollView!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first as? UITouch!) != nil
        {
            
           // scroll.endEditing(true)
            
            view.endEditing(true)
            
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    @IBAction func CreateAccount(_ sender: AnyObject) {
        
        Auth.auth().createUser(withEmail: Username.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil
            {
                
            }
            else
            {
                //print("User Created")
                //  self.login()
            }
        })
    }
    
    
 
    
    func login()
    {
       
        Auth.auth().signIn(withEmail: Username.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil
            {
               let alert = UIAlertController(title:"Неверная почта или пароль", message:"Повторите попытку", preferredStyle:UIAlertControllerStyle.alert);
                
                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                 self.present(alert, animated:true, completion:nil)
            }
            else
            {
                //print("OK")
               //  self.dismissViewControllerAnimated(true, completion: nil)
                if Auth.auth().currentUser?.uid != nil
                {
                    if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "first") as? UINavigationController{
                        self.present(pageViewController, animated: true, completion: nil)
                        //  }
                        
                    }
                   // print("Ok")
                    //self.performSegueWithIdentifier("loging", sender: self)
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


