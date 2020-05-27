//
//  forgot password.swift
//  ABSauto
//
//  Created by Максим Евлентьев on 26.08.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase


class forgot_password: UIViewController, UITextFieldDelegate {

   
    @IBOutlet var Username: UITextField!
   
  
    @IBOutlet var reg: UIButton!
    
    @IBAction func send(_ sender: AnyObject) {
        
        Auth.auth().sendPasswordReset(withEmail: self.Username.text!, completion: { (error) in
            
            var title = ""
            var message = ""
            
            if error != nil
            {
                
                let alert = UIAlertController(title:"Введите Ваш адрес эл. почты", message:"", preferredStyle:UIAlertControllerStyle.alert);
                
                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

                self.present(alert, animated:true, completion:nil)
                //   title = "Oops!"
                message = (error?.localizedDescription)!
            }
            else
            {
                let alert = UIAlertController(title:"На Ваш адрес отправлено письмо", message:"Перейдите по ссылке в письме", preferredStyle:UIAlertControllerStyle.alert); alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

                self.present(alert, animated:true, completion:nil)
                //   title = "Oops!"
                
                title = "Success!"
                message = "Password reset email sent."
                self.Username.text = ""
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "log") as? login {
                    self.present(pageViewController, animated: true, completion: nil)
                    // }
                }
            }
        })

    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // textField.resignFirstResponder()
        
        if (textField == Username)
        {
            self.sendgo()
        }
       
        return false
    }
    func sendgo()
    {
        Auth.auth().sendPasswordReset(withEmail: self.Username.text!, completion: { (error) in
            
            var title = ""
            var message = ""
            
            if error != nil
            {
                
                let alert = UIAlertController(title:"Введите Ваш адрес эл. почты", message:"", preferredStyle:UIAlertControllerStyle.alert);
                
            alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                //   title = "Oops!"
                message = (error?.localizedDescription)!
            }
            else
            {
                let alert = UIAlertController(title:"На Ваш адрес отправлено письмо", message:"Перейдите по ссылке в письме", preferredStyle:UIAlertControllerStyle.alert);
                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                //   title = "Oops!"
                
                title = "Success!"
                message = "Password reset email sent."
                
                    // }
                
            }
        })
        
   
    }

    override func viewDidLoad() {
        self.Username.becomeFirstResponder()

        reg.layer.cornerRadius = 5.0
        // scrolling.contentSize.height=350
        reg.layer.masksToBounds = true
        self.Username.delegate = self
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
   
}
