//
//  FirstView.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 22.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase
import CloudKit
class FirstView: UIViewController, UITextFieldDelegate {

    let publicDatabase = CKContainer.default().publicCloudDatabase

    @IBOutlet var Username: UITextField!
   
    @IBOutlet var Password: UITextField!
    
      @IBAction func back(_ sender: AnyObject) {
         self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch!
        {
            view.endEditing(true)
            
        }
        super.touchesBegan(touches, with: event)
    }

    @IBOutlet var again: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // textField.resignFirstResponder()
        
        if (textField == Username)
        {
            self.Password.becomeFirstResponder()
        }
        if (textField == Password)
        {
            self.again.becomeFirstResponder()
        }
        if (textField == again)
        {
            self.registering()

        }
        return false
    }
   

    @IBAction func register(_ sender: AnyObject) {
        
        self.registering()

        
    }
    @IBOutlet var reg: UIButton!
    
func registering()
{
    let randomNum:UInt32 = arc4random_uniform(888888)+111111 // range is 0 to 99
    
    // convert the UInt32 to some other types
    
    let randomTime:TimeInterval = TimeInterval(randomNum)
    
    let someInt:Int = Int(randomNum)
    
    let someString:String = String(randomNum) //string works too

    //print()
    if (self.Password.text!.lengthOfBytes(using: String.Encoding.utf8) >= 6)
    {
        if Password.text == again.text
        {
            
            Auth.auth().createUser(withEmail: Username.text!, password: Password.text!, completion: {
                user, error in
                
              
                if error != nil
                {
                    let alert = UIAlertController(title:"Почта уже зарегистрирована", message:"Повторите попытку", preferredStyle:UIAlertControllerStyle.alert);
                    alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

                    self.present(alert, animated:true, completion:nil)
                }
                else
                {
                    
                    let store = CKRecord(recordType: "Base")
                    // var search
                    store.setObject(self.Username.text as CKRecordValue?, forKey: "Mail")
                    store.setObject(someString as CKRecordValue?, forKey: "Code")
                    store.setObject("0" as CKRecordValue?, forKey: "Points")
                      store.setObject("0" as CKRecordValue?, forKey: "Date")

                    
                    store.setObject(0 as CKRecordValue?, forKey: "Bonus")
                    //print("1")
                    self.publicDatabase.save(store, completionHandler:
                        ({returnRecord, error in
                            
                            
                        }))
                    
                    

                    self.login()
                    
                    //self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
            
        else
        {
            let alert = UIAlertController(title:"Пароли не совпадают", message:"Повторите попытку", preferredStyle:UIAlertControllerStyle.alert);
            
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

            self.present(alert, animated:true, completion:nil)
        }
    }
        
        
    else
    {
        let alert = UIAlertController(title:"Слишком короткий пароль", message:"Пароль должен состоять минимум из 6 символов", preferredStyle:UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

        self.present(alert, animated:true, completion:nil)
    }
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    func login()
    {
     //   FIRAuth.auth()?.signInAnonymously(completion: {
       //     user, error in
            
         //   if error != nil
           // {
                
            //}
            //else
            //{
            //}
            
       // })
        Auth.auth().signIn(withEmail: Username.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil
            {
                
            }
            else
            {
                //print("OK")
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "first") as? UINavigationController{
                    self.present(pageViewController, animated: true, completion: nil)
                    //  }
                    
                }

               // self.dismissViewControllerAnimated(true, completion: nil)
               // if let pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("tab") as? UITabBarController {
                    //self.presentViewController(pageViewController, animated: true, completion: nil)
                    // }
                //}
                
                
            }
            
            
            //FirstView()
        })

    }
   
    @IBOutlet var ScrolView: UIScrollView!
   // func textFieldDidBeginEditing(textField: UITextField) {
        //ScrolView.setContentOffset(CGPointMake(0, 60), animated: )
  //  }
    
    
    
    override func viewDidLoad() {
        //...
        reg.layer.cornerRadius = 5.0
       // scrolling.contentSize.height=350
        reg.layer.masksToBounds = true
        self.Username.delegate = self
        self.Password.delegate = self
        self.again.delegate = self
        self.Username.becomeFirstResponder()
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        //...
    }
    
    
}
