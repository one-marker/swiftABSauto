//
//  CodeLoginIn.swift
//  ACSprojects
//
//  Created by Максим on 20.09.17.
//  Copyright © 2017 Максим Евлентьев. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class CodeLoginIn: UIViewController, UITextFieldDelegate {
    var ref: DatabaseReference!
    @IBOutlet weak var text: UILabel!
    var PhoneNumber: String = ""
    var CodeNumber: String = ""
    var buttonStatus: Bool = true
    @IBOutlet var loading: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    
    //ShowMessage
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 5.0
        self.Code.delegate = self
        self.Code.becomeFirstResponder()
         Auth.auth().signInAnonymously(completion: nil)
        print("PhoneNumber: ",PhoneNumber)
        if PhoneNumber == "+7"
        {
            text.text!=""
        }
        else
        {
        text.text! = "На номер "+PhoneNumber+" было отпралено смс с кодом подтверждения"
        }
        self.Code.addTarget(self, action: #selector(self.textFieldDidChanged(_:)), for: .editingChanged)
            // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField)
    {
        if self.Code.text!.characters.count == 6
        {
            log()
        }
    }
    @IBOutlet weak var Code: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    func errorMes()
    {
        disapper()
        let alert = UIAlertController(title:"Что то не так!", message: "Неверный код", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Окей",style: .cancel, handler: nil)
     
        alert.addAction(cancel)
        self.present(alert,animated: true,completion: nil)
    }
    func enter()
    {
        do{
           // try Auth.auth().signOut()
            // self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        catch let error as NSError
        {
            
        }
        
        let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: Code.text!)
        Auth.auth().signIn(with: credential) {(user,error) in
            if error != nil {
                print("error")
                self.errorMes()
            }
            else{
                let userInfo = user?.providerData[0]
                self.performSegue(withIdentifier: "logged", sender: Any?.self)
                
            }
            
        }
        
    }
    
    
    func register(){
        let UserPhone = self.ref.child("Users").child(PhoneNumber)
        
        let phoneBase = UserPhone.child("Phone")
        phoneBase.setValue(PhoneNumber)
        
        let bonus = UserPhone.child("Bonus")
        bonus.setValue("0")
        
        let status = UserPhone.child("Status")
        status.setValue("0")
        
        let code = UserPhone.child("Code")
        code.setValue(CodeNumber)
        
        let date = UserPhone.child("Date")
        date.setValue("0")
      //  var  timer1 = Timer.scheduledTimer(timeInterval: 1.5, target:self, selector: "myMetod1:", userInfo: nil, repeats: true)
    }
    func disapper()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
          
        })
        {(success:Bool) in
            self.loading.removeFromSuperview()
            
        }
    }
    @IBAction func LoginIn(_ sender: Any) {
       
        if buttonStatus == true
        {
        buttonStatus = false
        log()
        }
        else
        {
            print("in proceess")
        }
        
        
       }
    
    func log()
    {
       
        //
        lm()
        
        //
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["Phone"] as? String ?? ""
            //  let user = User.init(username: username)
            
            print("Phone",username)
            if username == ""{
                print("nil")
                print("registering...")
                self.register()
                print("entering")
                
                
                self.enter()
                
            }
            else
            {
                self.enter()
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
            print ("notInBase")
        }
        buttonStatus = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
