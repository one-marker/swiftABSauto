//
//  PhoneNumberLogin.swift
//  ACSprojects
//
//  Created by Максим on 20.09.17.
//  Copyright © 2017 Максим Евлентьев. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class PhoneNumberLogin: UIViewController, UITextFieldDelegate {
    var ref: DatabaseReference!
  
    @IBOutlet weak var visualeffect: UIVisualEffectView!
   
    @IBOutlet var loading: UIView!
    @IBOutlet weak var FirstNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        button.layer.cornerRadius = 5.0
       // textfieldR.layer.cornerRadius = 5.0
        
        self.Phone.delegate = self
        self.Phone.becomeFirstResponder()
        self.Phone.addTarget(self, action: #selector(self.textFieldDidChanged(_:)), for: .editingChanged)
        
        Auth.auth().signInAnonymously(completion: nil)
        /*
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child("+79373663022").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["Phone"] as? String ?? ""
          //  let user = User.init(username: username)
            
            print("Phone",username)
            if username == ""{
                print("nil")
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
            print ("notInBase")
        }
*/
        
      //  let string1 = "корявый текст"
        
        
        
        
        
        
     //
        //let uid = Auth.auth().currentUser?.uid
      /*  let UserPhone = self.ref.child("Users").child("+7blablabla")
        
        let phoneBase = UserPhone.child("Phone")
        phoneBase.setValue("+7....")
        
        let bonus = UserPhone.child("Bonus")
        bonus.setValue(0)
        
        let status = UserPhone.child("Status")
        status.setValue(0)
        
        let code = UserPhone.child("Code")
        code.setValue(0)
        
        let date = UserPhone.child("Date")
        date.setValue(0)
        
        */
       // let str = "0123456789"
        //let result = String(str.characters.first(2))
    
        //ref = Database.database().reference().child("Users").child("+79373663021").setValue("1")
        //
       
        
              // Do any additional setup after loading the view.
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var Phone: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        
        let number: CodeLoginIn = segue.destination as! CodeLoginIn
        number.PhoneNumber = self.FirstNumber.text!+self.Phone.text!
        number.CodeNumber = self.Phone.text!
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SendCode(_ sender: Any) {
       
        
            send()
        
  
        
    }
    
    func lm()
    {
        self.loading.layer.cornerRadius = 15
        self.view.addSubview(self.loading)
        self.loading.center = self.view.center
        self.loading.alpha = 2
        self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.5)
        {
            //self.visualeffect.effect = self.effect
            self.loading.transform = CGAffineTransform.identity
        }
    }
    func send()
    {
       
        var end  = self.Phone.text!.characters.count
        var newNumber = ""
        if end == 10
        {
        let str = self.Phone.text!
        var nomer = Array(str)[0...9]
        for nomer in nomer {
           newNumber=newNumber+[nomer]
        }
        
        self.Phone.text! = newNumber
        }
        print("Phone",newNumber)
        let alert = UIAlertController(title:"Номер телефона", message: "Это ваш номер телефона? \n \("+7"+newNumber)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default) { (UIAlertAction) in
            //сообщение
                self.lm();
            PhoneAuthProvider.provider().verifyPhoneNumber("+7"+newNumber) {(verificationID, error) in
                
                if error != nil{
                    print("error")
                    
                }
                else{
                    UIView.animate(withDuration: 0.3, animations: {
                        self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                      
                    })
                    {(success:Bool) in
                        self.loading.removeFromSuperview()
                        
                    }
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID,forKey:"authVID")
                    self.performSegue(withIdentifier: "Show", sender: Any?.self)
                    
                }
            }
        }
        let cancel = UIAlertAction(title: "Нет",style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert,animated: true,completion: nil)
    }
    @objc func textFieldDidChanged(_ textField: UITextField)
    {
       // let nsString = textField.text as NSString?
        //let newString = nsString?.replacingCharacters(in: 0, with: 10)
        if self.Phone.text!.characters.count == 10
        {
           send()
        }
    }
    //внешний вид кнопки и  textfield
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var textfieldR: UITextField!
    
    
    
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
