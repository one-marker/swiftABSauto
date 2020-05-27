//
//  CloudViewController.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 02.12.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import CloudKit
import FirebaseAuth
import Firebase

class CloudViewController: UIViewController, UITextFieldDelegate {
    var ref: DatabaseReference!
    @IBOutlet var addBonusMessgae: UIView!
    let publicDatabase = CKContainer.default().publicCloudDatabase
    // var effect:UIVisualEffect!
    var PhoneNumber = ""
    var Bonus = ""
    var CodeInBase = ""
    @IBOutlet weak var visualeffect: UIVisualEffectView!
    @IBOutlet weak var operation: UILabel!
    @IBOutlet var loading: UIView!
    var array2 = [CKRecord]()
   var enable = 1
    @IBOutlet weak var codetext: UITextField!
    @IBOutlet weak var text: UITextField!
    
    
    @IBAction func HiideKeyBoard(_ sender: Any)
    {
    
        self.view.endEditing(true)
    
    }

    
    @IBAction func cancelMessage(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addBonusMessgae.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
           // self.visualeffect.effect = nil
            // effect = visualeffect.effect
            // visualeffect.effect = nil
       //     self.visualeffect.alpha = -1
        })
        {(success:Bool) in
            self.addBonusMessgae.removeFromSuperview()
            
        }
       // self.addBonusMessgae.removeFromSuperview()
    }
    
    
    func check()
    {
         //mail = ""
        
        
           /*
        PhoneNumber = (Auth.auth().currentUser?.phoneNumber)!
        
        
        let outpredicate1 = NSPredicate(value: true)
        let query1 = CKQuery(recordType: "UserOfCode", predicate:outpredicate1)
        query1.sortDescriptors = [NSSortDescriptor(key: "code", ascending: false)]
        publicDatabase.perform(query1, inZoneWith: nil, completionHandler:{ (results1, error) in
            if error != nil{
                print("error" + error.debugDescription)
            }
            else{
                for results3 in results1!
                {
                    //let store3 = results3 as CKRecord
                    var search2 = results3.value(forKey: "code") as! String?
                    if search2 == self.codetext.text!
                    {
                          let store3 = results3 as CKRecord
                        //  let store1 = results2 as CKRecord
                        
                        var mailwithcode = (store3.value(forKey: "mail") as! String?)!
                        
                        if mailwithcode == PhoneNumber
                        {
                            print("ThiscodeUsed")
                        }
                    }
                    else
                    {
                        
                    }
                }
            }
            
        }
        )
        */
    }
    @IBAction func update_bonus_button(_ sender: Any) {
        update()
    }
    override func viewDidLoad() {
   //     super.viewDidLoad()
      //  effect = visualeffect.effect
      //  visualeffect.effect = nil
      //  visualeffect.alpha = -1
        //
        self.codetext.addTarget(self, action: #selector(self.textFieldDidChanged(_:)), for: .editingChanged)
       
 
    update()
        
     
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField)
    {
        if self.codetext.text!.characters.count == 10
        {
            activate()
        }
    }
    func update()
    {
        PhoneNumber = (Auth.auth().currentUser?.phoneNumber)!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.Bonus = value?["Bonus"] as? String ?? ""
            self.CodeInBase = value?["Code"] as? String ?? ""
            //  let user = User.init(username: username)
            
            //print("Bonus",)
            //self.bonus.text = bonusVal+" Б"
           
                self.code.text! = self.CodeInBase
                self.yourbonus.text! = String(self.Bonus)+" Б"
                
            
            // ...
        }) { (error) in
            //print(error.localizedDescription)
            print ("notInBase")
        }
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func checkUse(){
        
      //  let userID = Auth.auth().currentUser?.uid
        ref.child("UserOfCode").child("Used").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //  self.Bonus = value?["Bonus"] as? String ?? ""
            var use = value?[self.CodeInBase+"-"+self.codetext.text!] as? String ?? ""
            //  let user = User.init(username: username)
            print(self.CodeInBase+"-"+self.codetext.text!+" = "+use)
        
            if self.CodeInBase+"-"+self.codetext.text! == use
            {
               
                 self.loading.removeFromSuperview()
                
                
                //self.update()
                let ErrorUse = UIAlertController(title:"Упс :(", message:"Вы уже использовади это промокод", preferredStyle:UIAlertControllerStyle.alert);
                ErrorUse.addAction(UIAlertAction(title: "Окей", style: .default, handler:{(action: UIAlertAction!) -> Void in
                })
                    
                )
                self.present(ErrorUse, animated:true, completion:nil)
               
                
            }
            else{
                self.loading.removeFromSuperview()
                self.update()
                // добавить себе 1 бонус
                var b: Int = Int(self.Bonus)!
                b = b + 1
                var bString: String = String(b)
                let AddBonus = self.ref.child("Users").child(self.PhoneNumber)
                let UserOfCode = self.ref.child("UserOfCode").child("Used")
                
                let bonus = AddBonus.child("Bonus")
                bonus.setValue(bString)
                // добавить ему
                self.ref1 = Database.database().reference()
                self.ref1.child("Users").child("+7"+self.codetext.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    var bonusHim = value?["Bonus"] as? String ?? ""
                   // self.CodeInBase = value?["Code"] as? String ?? ""
                    //  let user = User.init(username: username)
                    var bhim: Int = Int(bonusHim)!
                    bhim = bhim + 1
                    var bhimString: String = String(bhim)
                   
                    let AddBonusHim = self.ref1.child("Users").child("+7"+self.codetext.text!)
                    let NeWbonusHim = AddBonusHim.child("Bonus")
                    NeWbonusHim.setValue(bhimString)
                    
                    // ...
                }) { (error) in
                    //print(error.localizedDescription)
                    print ("notInBase")
                }
              
                
                
                
                //сообщение
                let use = UserOfCode.child(self.code.text!+"-"+self.codetext.text!)
                use.setValue(self.code.text!+"-"+self.codetext.text!)
                let use2 = UserOfCode.child(self.codetext.text!+"-"+self.code.text!)
                use2.setValue(self.codetext.text!+"-"+self.code.text!)
                self.addBonusMessgae.layer.cornerRadius = 15
                self.view.addSubview(self.addBonusMessgae)
                self.addBonusMessgae.center = self.view.center
                self.addBonusMessgae.alpha = 3
                self.addBonusMessgae.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                
                UIView.animate(withDuration: 0.5)
                {
                    //self.visualeffect.effect = self.effect
                    self.addBonusMessgae.transform = CGAffineTransform.identity
                }
                print(bString)
                 print("addOne")
            }
            //print("Bonus",)
            //self.bonus.text = bonusVal+" Б"
            
            //     self.code.text! = self.CodeInBase
            //   self.yourbonus.text! = String(self.Bonus)+" Б"
            
            
            // ...
        }) { (error) in
            //print(error.localizedDescription)
            print ("notInBase")
        }
      //   self.codetext.text = ""
    }
    func activate()
    {
        enable = 0
        view.endEditing(true)
        if code.text != codetext.text {
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
            
            
            var t2 = 0
            //активация промокода
            print("Go")
            //let userID = Auth.auth().currentUser?.uid
            
            ref.child("Users").child("+7"+self.codetext.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                //  self.Bonus = value?["Bonus"] as? String ?? ""
                let codeExist = value?["Code"] as? String ?? ""
                //  let user = User.init(username: username
                print("1")
                print(codeExist)
                if codeExist == self.codetext.text && self.codetext.text != ""
                {
                    
                    print("OK")
                    self.checkUse()
                    
                    
                    
                }
                else{
                    self.loading.removeFromSuperview()
                    let ErrorUse = UIAlertController(title:"Что то не так", message:"Вы ввели не существующий промокод", preferredStyle:UIAlertControllerStyle.alert);
                    ErrorUse.addAction(UIAlertAction(title: "Ок", style: .default, handler:{(action: UIAlertAction!) -> Void in
                    })
                        
                    )
                    self.present(ErrorUse, animated:true, completion:nil)
                    
                }
                //print("Bonus",)
                //self.bonus.text = bonusVal+" Б"
                
                //     self.code.text! = self.CodeInBase
                //   self.yourbonus.text! = String(self.Bonus)+" Б"
                
                
                // ...
            }) { (error) in
                //print(error.localizedDescription)
                print ("notInBase")
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            /*
             let outpredicate = NSPredicate(value: true)
             let query = CKQuery(recordType: "Base", predicate:outpredicate)
             query.sortDescriptors = [NSSortDescriptor(key: "Code", ascending: false)]
             publicDatabase.perform(query, inZoneWith: nil, completionHandler:{ (results, error) in
             if error != nil{
             print("error" + error.debugDescription)
             }
             else{
             for results2 in results!
             {
             // posts.append(results2)
             
             var t = results?.count
             
             
             var search = results2.value(forKey: "Code") as! String?
             if search == self.codetext.text
             {
             }
             else
             {
             t2 = t2 + 1
             print(t2,t)
             
             if t2 == t
             {
             UIView.animate(withDuration: 0.3, animations: {
             self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
             //  self.visualeffect.effect = nil
             // effect = visualeffect.effect
             // visualeffect.effect = nil
             // self.visualeffect.alpha = -1
             })
             {(success:Bool) in
             self.loading.removeFromSuperview()
             
             }
             print("no1")
             let alert1 = UIAlertController(title:"Промокод не существует", message:"Введите другой промокод", preferredStyle:UIAlertControllerStyle.alert);
             
             
             alert1.addAction(UIAlertAction(title: "ОК", style: .default, handler: {(action: UIAlertAction!) -> Void in
             UIView.animate(withDuration: 0.5, animations: {
             self.enable = 1
             
             self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
             //  self.visualeffect.effect = nil
             // effect = visualeffect.effect
             // visualeffect.effect = nil
             // self.visualeffect.alpha = -1
             })
             {(success:Bool) in
             self.loading.removeFromSuperview()
             
             }
             })
             
             )
             self.present(alert1, animated:true, completion:nil)
             break
             }
             }
             }
             
             }
             })
             //check()
             print("yes")
             
             var mail = ""
             
             if Auth.auth().currentUser?.isAnonymous == true{
             }
             else{
             
             mail = (Auth.auth().currentUser?.email)!         }
             
             let outpredicate1 = NSPredicate(value: true)
             let query1 = CKQuery(recordType: "UserOfCode", predicate:outpredicate1)
             query1.sortDescriptors = [NSSortDescriptor(key: "code", ascending: false)]
             publicDatabase.perform(query1, inZoneWith: nil, completionHandler:{ (results1, error) in
             var k = results1?.count
             var k2 = 0
             
             var mailwithcode = ""
             if error != nil{
             print("error" + error.debugDescription)
             }
             else{
             
             //   l2 = l2+1
             
             for results3 in results1!
             {
             // var l2 = results1?.count
             //  var l = 0
             
             //print("s")
             var search = results3.value(forKey: "code") as! String?
             var serach1 = results3.value(forKey: "mail") as! String?
             //print (search,serach1)
             if search == self.codetext.text && serach1 == mail
             {
             let message1 = UIAlertController(title:"Вы уже использовали этот промокод", message:"Введите другой промокод", preferredStyle:UIAlertControllerStyle.alert);
             
             
             message1.addAction(UIAlertAction(title: "ОК", style: .default, handler: {(action: UIAlertAction!) -> Void in
             UIView.animate(withDuration: 0.5, animations: {
             self.enable = 1
             self.codetext.text!=""
             
             self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
             //  self.visualeffect.effect = nil
             // effect = visualeffect.effect
             // visualeffect.effect = nil
             // self.visualeffect.alpha = -1
             })
             {(success:Bool) in
             self.loading.removeFromSuperview()
             
             }
             })
             
             )
             self.present(message1, animated:true, completion:nil)
             self.enable = 1
             
             var store3 = results3 as CKRecord
             //  let store1 = results2 as CKRecord
             //                      print(results3.count)
             mailwithcode = (store3.value(forKey: "mail") as! String?)!
             //  print(mail,mailwithcode)
             }
             else
             {
             // print("plus for him and you 2")
             //var k = 0
             k2 = k2+1
             if k == k2
             {
             self.plusbonusforyou()
             self.plusforhim()
             // bad
             // break
             // print(t,t2)
             }
             else{
             //k = 1
             //if k == 0
             //{
             //self.plusforhim()
             // }
             }
             }
             
             }
             
             
             
             }
             //end while
             })
             
             
             }
             else
             {
             let message = UIAlertController(title:"Нельзя использовать свой промокод", message:"Введите другой промокод", preferredStyle:UIAlertControllerStyle.alert);
             
             
             message.addAction(UIAlertAction(title: "ОК", style: .default, handler: {(action: UIAlertAction!) -> Void in
             UIView.animate(withDuration: 0.5, animations: {
             self.codetext.text!=""
             
             self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
             //  self.visualeffect.effect = nil
             // effect = visualeffect.effect
             // visualeffect.effect = nil
             // self.visualeffect.alpha = -1
             })
             {(success:Bool) in
             self.loading.removeFromSuperview()
             
             }
             })
             
             )
             self.present(message, animated:true, completion:nil)
             self.enable = 1
             
             }*/
            
        }
        else{
            let ErrorUse = UIAlertController(title:"Так нельзя", message:"Вы не можете вводить свой промокод", preferredStyle:UIAlertControllerStyle.alert);
            ErrorUse.addAction(UIAlertAction(title: "Я понял", style: .default, handler:{(action: UIAlertAction!) -> Void in
            })
                
            )
            self.present(ErrorUse, animated:true, completion:nil)
        }
        
        
    }
     var ref1: DatabaseReference!
    @IBAction func activatecode(_ sender: Any) {
       activate()
       // self.visualeffect.alpha = 1
       // self.ViewContainerForm.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
       // UIView.animate(withDuration: 0.5)
        //{
                 //      self.ViewContainerForm.transform = CGAffineTransform.identity
       // }
        
   
    }
    func plusforhim()
    {
        let outpredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Base", predicate:outpredicate)
        query.sortDescriptors = [NSSortDescriptor(key: "Code", ascending: false)]
        publicDatabase.perform(query, inZoneWith: nil, completionHandler:{ (results, error) in
            if error != nil{
                print("error" + error.debugDescription)
            }
            else{
                for results2 in results!
                {
                    // posts.append(results2)
                 
                    
                    
                    var search = results2.value(forKey: "Code") as! String?
                    if search == self.codetext.text
                    {
                        print("ok")
                        
                        let store1 = results2 as CKRecord
                        // var status = (store1.value(forKey: "Status") as! String?)!
                        var bonus = (store1.value(forKey: "Bonus") as! Int?)!
                        
                        
                        //self.plusbonusforyou()
                        var b =  Int(bonus) + 1
                        print(b)
                        //store1.setObject("able" as CKRecordValue?, forKey: "Status")
                        //  store1.setObject(someString as CKRecordValue?, forKey: "Status")
                        store1.setObject(b as CKRecordValue?, forKey: "Bonus")
                        
                        self.publicDatabase.save(store1, completionHandler:
                            ({returnRecord, error in
                                if error != nil{
                                    print("error" + error.debugDescription)
                                }
                                else{
                                print("he have bonus")
                                   
                                    UIView.animate(withDuration: 0.3, animations: {
                                        self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                                   
                                      //  self.visualeffect.effect = nil
                                        // effect = visualeffect.effect
                                        // visualeffect.effect = nil
                                       // self.visualeffect.alpha = -1
                                    })
                                    {(success:Bool) in
                                        self.loading.removeFromSuperview()
                                        
                                    }
                                }
                            }))
                        break
                    }
                    else
                    {
                        print("no bonus")
                    }
                    
                }
                // print(posts)
            }
        })
    }
    func plusbonusforyou()
    {
        var number = 0
        print("you")
        
        var mail = ""
        
        if Auth.auth().currentUser?.isAnonymous == true{
        }
        else{
            
            mail = (Auth.auth().currentUser?.email)!         }
        
        
        
        
        let outpredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Base", predicate:outpredicate)
        query.sortDescriptors = [NSSortDescriptor(key: "Code", ascending: false)]
        publicDatabase.perform(query, inZoneWith: nil, completionHandler:{ (results, error) in
            if error != nil{
                print("error" + error.debugDescription)
            }
            else{
                for results2 in results!
                {
                    // posts.append(results2)
                    
                    
                    
                    var search = results2.value(forKey: "Code") as! String?
                    if search == self.codetext.text
                    {
                       
                                               let outpredicate1 = NSPredicate(value: true)
                        let query1 = CKQuery(recordType: "Base", predicate:outpredicate)
                        query1.sortDescriptors = [NSSortDescriptor(key: "Mail", ascending: false)]
                        self.publicDatabase.perform(query1, inZoneWith: nil, completionHandler:{ (results1, error) in
                            if error != nil{
                                print("error" + error.debugDescription)
                            }
                            else{
                                for results3 in results1!
                                {
                                    var smail = results3.value(forKey: "Mail") as! String?
                                    if smail == mail
                                    {
                                        var store1 = results3 as CKRecord
                                        
                                        // var status = (store1.value(forKey: "Status") as! String?)!
                                        var bonus = (store1.value(forKey: "Bonus") as! Int?)!
                                        
                                        print(bonus)
                                        
                                        var b =  Int(bonus) + 1
                                        self.yourbonus.text! = String(b) + " Б"
                                        print(b)
                                        //store1.setObject("able" as CKRecordValue?, forKey: "Status")
                                        store1.setObject(b as CKRecordValue?, forKey: "Bonus")
                                        
                                        self.publicDatabase.save(store1, completionHandler:
                                            ({returnRecord, error in
                                                
                                                print("you have bonus")
                                            }))
                                        let store = CKRecord(recordType: "UserOfCode")
                                        // var search
                                        store.setObject(mail as CKRecordValue?, forKey: "mail")
                                        store.setObject(self.codetext.text! as CKRecordValue?, forKey: "code")
                                        print("1")
                                        self.publicDatabase.save(store, completionHandler:
                                            ({returnRecord, error in
                                                
                                     //  self.operation.text = "
                                                let alert = UIAlertController(title:"Пополнение счёта", message:"На ваш счёт зачислен 1 бонус", preferredStyle:UIAlertControllerStyle.alert);
                                                
                                                
                                                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: {(action: UIAlertAction!) -> Void in
                                                    UIView.animate(withDuration: 0.5, animations: {
                                                        self.codetext.text!=""

                                                        self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                                                        //  self.visualeffect.effect = nil
                                                        // effect = visualeffect.effect
                                                        // visualeffect.effect = nil
                                                        // self.visualeffect.alpha = -1
                                                    })
                                                    {(success:Bool) in
                                                        self.loading.removeFromSuperview()
                                                        
                                                    }
                                                })
                                                    
                                                )
                                                self.present(alert, animated:true, completion:nil)
                                                number=1
                                               self.enable = 1
                                            }))
                                        break
                                    }
                                    else
                                    {
                                        print("error")
                                        
                                    }
                                }
                            }
                        }
                        )
                        
                       
                        
                    }
                    else
                    {
                       // number=number+1
                    }
                    
                }
                // print(posts)
            }
        })
       // print(number)
        
    }
    
    @IBAction func load(_ sender: Any) {
        loadData()
    }
    @IBAction func share_friends(_ sender: Any) {
        
      let text = "\nПолучи запчасти бесплатно! Рекомендую приложение ABSauto \n1. Скачай приложение по ссылке https://itunes.apple.com/us/app/absauto/id1151032448?l=ru&ls=1&mt=8  \n2. Введи мой ПРОМОКОД "
        
        //рассказать друзьям
        let myWebsite = NSURL(string: "https://itunes.apple.com/us/app/absauto/id1151032448?l=ru&ls=1&mt=8")
        let vc = UIActivityViewController(activityItems: ["ПРОМОКОД - " + code.text! + text + code.text! + " - получишь бонусы! \n3. Приходи в ABSauto и предъявляй купоны прямо с экрана телефона!" ], applicationActivities: nil)
                                                 self.present(vc,animated: true, completion: nil)
        
      ///  let textToShare = "Swift is awesome!  Check out this website about it!"
        
    ///    if let myWebsite = NSURL(string: "https://itunes.apple.com/us/app/absauto/id1151032448?l=ru&ls=1&mt=8") {
    ///        let objectsToShare = [textToShare, myWebsite] as [Any]
    //        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
          //  activityVC.popoverPresentationController?.sourceView = sender
     //       self.present(activityVC, animated: true, completion: nil)
    //    }
        
    }
    @IBOutlet weak var code: UILabel!
    
    @IBOutlet weak var label: UILabel!
    func loadData(){
        var posts = [CKRecord]()
        
        
        let outpredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Base", predicate:outpredicate)
        query.sortDescriptors = [NSSortDescriptor(key: "Phone", ascending: false)]
        publicDatabase.perform(query, inZoneWith: nil, completionHandler:{ (results, error) in
            if error != nil{
                print("error" + error.debugDescription)
            }
            else{
                for results2 in results!
                {
                    posts.append(results2)
                    
                    var search = results2.value(forKey: "Phone") as! String?
                    if search == "567"
                    {
                        print("ok")
                    }
                }
                // print(posts)
            }
        })
    }
    
    @IBOutlet weak var yourbonus: UILabel!
    
    
    @IBAction func go(_ sender: Any) {
        print("yes")
        
        
        var posts = [CKRecord]()
        
        
        let outpredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Base", predicate:outpredicate)
        query.sortDescriptors = [NSSortDescriptor(key: "Phone", ascending: false)]
        publicDatabase.perform(query, inZoneWith: nil, completionHandler:{ (results, error) in
            if error != nil{
                print("error" + error.debugDescription)
            }
            else{
                for results2 in results!
                {
                    posts.append(results2)
                    
                    var search = results2.value(forKey: "Phone") as! String?
                    if search == "567"
                    {
                        print("ok")
                        
                        let store1 = results2 as CKRecord
                        store1.setObject("Hello" as CKRecordValue?, forKey: "Phone")
                        self.publicDatabase.save(store1, completionHandler:
                            ({returnRecord, error in
                                
                                if let err = error {
                                    // save operation failed
                                } else {
                                    // save operation succeeded
                                }
                            }))
                    }
                    
                }
                // print(posts)
            }
        })
        
        let store = CKRecord(recordType: "Base")
        // var search
        store.setObject(text.text as CKRecordValue?, forKey: "Phone")
        print("1")
        publicDatabase.save(store, completionHandler:
            ({returnRecord, error in
                
                if let err = error {
                    // save operation failed
                } else {
                    // save operation succeeded
                }
            }))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
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
