//
//  protected.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 22.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CloudKit

class protected: UIViewController,UITabBarDelegate{
    let publicDatabase = CKContainer.default().publicCloudDatabase
    //@IBOutlet weak var process: UILabel!
    
    @IBOutlet var addBonusMessgae: UIView!
    
    var PhoneNumber = ""
    var Bonus = ""
    var CodeInBase = ""
       //var ref1: DatabaseReference!
    var ref: DatabaseReference!
    var enable = 1
    var code: String?
    var score: String?
    var hightscore: String?
    var hightscore1 = 0
    var score1 = 0
    @IBAction func process(_ sender: Any) {
        view.endEditing(true)
    }
    @IBOutlet weak var process: UIButton!
    
    @IBAction func share(_ sender: Any) {
    }
    
    @IBAction func update(_ sender: Any) {
        
        var mail = ""
        
        if Auth.auth().currentUser?.isAnonymous == true{
        }
        else{
            
            mail = (Auth.auth().currentUser?.email)!         }
        
        // поределение code
        
        
        
        //var posts = [CKRecord]()
        
        
        var outpredicate = NSPredicate(value: true)
        var query = CKQuery(recordType: "Base", predicate:outpredicate)
        query.sortDescriptors = [NSSortDescriptor(key: "Mail", ascending: false)]
        publicDatabase.perform(query, inZoneWith: nil, completionHandler:{ (results, error) in
            if error != nil{
                print("error" + error.debugDescription)
            }
            else{
                for results2 in results!
                {
                    //posts.append(results2)
                    print("yes")
                    
                    var search = results2.value(forKey: "Mail") as! String?
                    if search == mail
                    {
                        print("ok")
                        
                        let store1 = results2 as CKRecord
                        
                        var code = (store1.value(forKey: "Code") as! String?)!
                        var bonus = (store1.value(forKey: "Bonus") as! Int?)!
                        print(code)
                        DispatchQueue.main.async {
                            self.code = code
                            self.Yourbonus.text! = String(bonus) + " Б"
                            
                        }
                        break
                    }
                    
                    
                }
                // print(posts)
            }
        })
        
    }
    func updating()
    {
        self.PhoneNumber = (Auth.auth().currentUser?.phoneNumber!)!
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Users").child(self.PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.Bonus = value?["Bonus"] as? String ?? ""
            self.CodeInBase = value?["Code"] as? String ?? ""
            //  let user = User.init(username: username)
            
            //print("Bonus",)
            //self.bonus.text = bonusVal+" Б"
            
            self.code = self.CodeInBase
            self.Yourbonus.text! = String(self.Bonus)+" Б5"
            
            
            // ...
        }) { (error) in
            //print(error.localizedDescription)
            print ("notInBase")
        }
    }
    
    @IBAction func Close(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.visualeffect.effect = nil
            // effect = visualeffect.effect
            self.visualeffect.effect = nil
            self.visualeffect.alpha = -1
        })
        {(success:Bool) in
            self.loading.removeFromSuperview()
            
        }
        /*
        UIView.animate(withDuration: 0.3, animations: {
            self.viewInfo.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.visualeffect.effect = nil
            // effect = visualeffect.effect
            // visualeffect.effect = nil
            self.visualeffect.alpha = -1
        })
        {(success:Bool) in
           // self.viewInfo.removeFromSuperview()
            //self.addBonusMessgae.removeFromSuperview()
            self.loading.removeFromSuperview()
        }
       
        //effect = visualeffect.effect
       // visualeffect.effect = nil
        //visualeffect.alpha = -1
        //self.loading.removeFromSuperview()
*/
    }
    func checkUse(){
        ref = Database.database().reference()
        //  let userID = Auth.auth().currentUser?.uid
        ref.child("UserOfCode").child("Used").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //  self.Bonus = value?["Bonus"] as? String ?? ""
            var use = value?[self.CodeInBase+"-"+self.Codetext.text!] as? String ?? ""
            //  let user = User.init(username: username)
            print(self.CodeInBase+"-"+self.Codetext.text!+" = "+use)
            
            if self.CodeInBase+"-"+self.Codetext.text! == use
            {
                
              //  self.loading.removeFromSuperview()
                
                
                //self.update()
                let ErrorUse = UIAlertController(title:"Упс :(", message:"Вы уже использовали это промокод", preferredStyle:UIAlertControllerStyle.alert);
                ErrorUse.addAction(UIAlertAction(title: "Окей", style: .default, handler:{(action: UIAlertAction!) -> Void in
                })
                    
                )
                self.present(ErrorUse, animated:true, completion:nil)
                
                
            }
            else{
                self.loading.removeFromSuperview()
                self.updating()
                // добавить себе 1 бонус
                var b: Int = Int(self.Bonus)!
                b = b + 1
                var bString: String = String(b)
                let AddBonus = self.ref.child("Users").child(self.PhoneNumber)
                let UserOfCode = self.ref.child("UserOfCode").child("Used")
                
                let bonus = AddBonus.child("Bonus")
                bonus.setValue(bString)
                // добавить ему
                self.ref = Database.database().reference()
                self.ref.child("Users").child("+7"+self.Codetext.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    var bonusHim = value?["Bonus"] as? String ?? ""
                    // self.CodeInBase = value?["Code"] as? String ?? ""
                    //  let user = User.init(username: username)
                    var bhim: Int = Int(bonusHim)!
                    bhim = bhim + 1
                    var bhimString: String = String(bhim)
                    
                    let AddBonusHim = self.ref.child("Users").child("+7"+self.Codetext.text!)
                    let NeWbonusHim = AddBonusHim.child("Bonus")
                    NeWbonusHim.setValue(bhimString)
                    
                    // ...
                }) { (error) in
                    //print(error.localizedDescription)
                    print ("notInBase")
                }
                
              //  self.Codetext.text = ""
                
                
                //сообщение
                let use = UserOfCode.child(self.CodeInBase+"-"+self.Codetext.text!)
                use.setValue(self.CodeInBase+"-"+self.Codetext.text!)
                let use2 = UserOfCode.child(self.Codetext.text!+"-"+self.CodeInBase)
                use2.setValue(self.Codetext.text!+"-"+self.CodeInBase)
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
    }
 
    
    @IBAction func cancel(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addBonusMessgae.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.visualeffect.effect = nil
            // effect = visualeffect.effect
            self.visualeffect.effect = nil
            self.visualeffect.alpha = -1
        })
        {(success:Bool) in
            self.addBonusMessgae.removeFromSuperview()
            
        }
    }
    
    
    
    
    @IBAction func activatecode(_ sender: Any) {
       activate()
    }
    func activate()
    {
        //update()
        ref = Database.database().reference()
        //ref = Database.database().reference()
        enable = 0
        view.endEditing(true)
        if Codetext.text != self.CodeInBase {
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
            
            self.ref.child("Users").child("+7"+self.Codetext.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                //  self.Bonus = value?["Bonus"] as? String ?? ""
                let codeExist = value?["Code"] as? String ?? ""
                //  let user = User.init(username: username
                print("1")
                print(codeExist)
                if codeExist == self.Codetext.text && self.Codetext.text != ""
                {
                    
                    print("OK")
                    self.checkUse()
                    
                    
                    
                }
                else{
                    // self.loading.removeFromSuperview()
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
            
            
        }
        else{
            let ErrorUse = UIAlertController(title:"Так нельзя", message:"Вы не можете вводить свой промокод", preferredStyle:UIAlertControllerStyle.alert);
            ErrorUse.addAction(UIAlertAction(title: "Я понял", style: .default, handler:{(action: UIAlertAction!) -> Void in
            })
                
            )
            self.present(ErrorUse, animated:true, completion:nil)
        }
        // self.Codetext.text!=""
        //self.process.titleLabel?.text = "Убрать клавиатуру"
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
                    if search == self.Codetext.text
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

    
    @IBOutlet weak var Codetext: UITextField!
    @IBOutlet weak var visualeffect: UIVisualEffectView!
    
    @IBOutlet var mail: UILabel!
    
      var effect:UIVisualEffect!
    
    @IBOutlet var loading: UIView!
  
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func YouTube(_ sender: AnyObject) {
        let web =
        "https://www.youtube.com/channel/UCkGfiGrjmb2V_5Vtw0_heZw"
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
    
    @IBAction func instagram(_ sender: AnyObject) {
        
        
        let web =
        "https://www.instagram.com/absautoru/"
        //go to link
        
        if let requestUrl = URL(string: web) {
            UIApplication.shared.openURL(requestUrl)
        }

    }
    @IBOutlet var begin: UIButton!
    @IBOutlet var instruct: UIButton!
    
    override func viewDidLoad() {
        //...
        self.visualeffect.alpha = -1
        //self.visualeffect.effect = nil

        //UITabBar.appearance().backgroundColor = UIColor.blackColor()
       // UITabBar.appearance().tintColor = UIColor.redColor()
//
        //обновление
              // self.viewInfo.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
       
        let higdef = UserDefaults.standard
        if (higdef.value(forKey: "Highscore") != nil){
            
            hightscore1 = higdef.value(forKey: "Highscore") as! NSInteger!
           // hightscore = NSString(format: "Highscore: %i",hightscore1 ) as String
            
        }
print("jjjj",hightscore)
        
        score1 = score1 + 1
        score = NSString(format: "Score: %i ", score1) as String
        if (hightscore1 == 1)
        {
            
            effect = visualeffect.effect

            self.viewInfo.layer.cornerRadius = 15
            self.view.addSubview(self.viewInfo)
            self.viewInfo.center = self.view.center
            self.visualeffect.alpha = 0.7
            self.viewInfo.centerXAnchor
            hightscore1 = 0
            hightscore = NSString(format: "Highscore : %i" , hightscore1) as String
            let higdef = UserDefaults.standard
            higdef.setValue(hightscore1, forKey: "Highscore")
            higdef.synchronize()
            
        }
      //  let higdef = UserDefaults.standard
   //     higdef.setValue(1, forKey: "Highscore")
     //   higdef.synchronize()


        //
        code = "456734"
        
              // visualeffect.isOpaque = true
       // myView.opaque = false // сообщаем системе что myView будет иметь полупрозрачные нарисованные элементы
        
    //    myView.alpha = 0.7
       // visualeffect.effect = nil
    //    visualeffect.alpha = 0.1
    
        begin.layer.cornerRadius = 5.0
        begin.layer.masksToBounds = true
        instruct.layer.cornerRadius = 5.0
        instruct.layer.masksToBounds = true
        if Auth.auth().currentUser?.uid == nil {
        Auth.auth().signInAnonymously(completion: {
            user, error in
           // print("annonim ok1")

            if error != nil
            {
              
            }
            else
            {
                  print("annonim ok")
                
                
            }
            
        })
       //
        }
      //     self.performSegue(withIdentifier: "loginView", sender: self)
           // mail.text = FIRAuth.auth()?.currentUser?.email
            
            
    //    }
   //   else
   //     {
            
   //     }
       
       // mail.text = FIRAuth.auth()?.currentUser?.email

    }
    
    @IBAction func close(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewInfo.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.visualeffect.effect = nil
            // effect = visualeffect.effect
            // visualeffect.effect = nil
            self.visualeffect.alpha = -1
        })
        {(success:Bool) in
            self.viewInfo.removeFromSuperview()
            
        }

    }
    @IBAction func more(_ sender: Any) {
        
       if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
        self.present(pageViewController, animated: true, completion: nil)
            }
        
        
    }
    
    
    @IBOutlet var viewInfo: UIView!
    
    @IBAction func LOOK(_ sender: AnyObject) {
        
        
        let optionMenu = UIAlertController(title: nil, message: "Что Вы хотите узнать?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {
            (action: UIAlertAction!) -> Void in
            
            
        })
        let instPhoto = UIAlertAction(title:  "Как отправить запрос?", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            let userDefaults = UserDefaults.standard
            // let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
            
            // if we haven't shown the walkthroughs, let's show them
            //   if !displayedWalkthrough {
            // instantiate neew PageVC via storyboard
            if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController1") as? PageViewController1 {
                self.present(pageViewController, animated: true, completion: nil)
                // }
            }


        })
        let instBonus = UIAlertAction(title:  "Как заработать бонусы?", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            let userDefaults = UserDefaults.standard
            // let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
            
            // if we haven't shown the walkthroughs, let's show them
            //   if !displayedWalkthrough {
            // instantiate neew PageVC via storyboard
            if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
                self.present(pageViewController, animated: true, completion: nil)
                }
           // }
            
            
        })

    
               optionMenu.addAction(cancelAction)
        optionMenu.addAction(instPhoto)
         optionMenu.addAction(instBonus)
       /// optionMenu.addAction(bonus)
          self.present(optionMenu, animated: true, completion: nil)
        

    }
   override func viewWillAppear(_ animated: Bool) {
        //mail.text = FIRAuth.auth()?.currentUser?.email
  //  UITabBar.selectedItem = 2
    //tabBar()
    let tabbar = UITabBar()//if declare and initilize like this
    
    //tabbar.selectedItem = UITabBarItem.items?[1]
  //  UITabBar.selectedItem =  UITabBar.items![1]
    }
    @IBOutlet weak var Yourbonus: UILabel!
    @IBAction func begin(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Что Вы хотите сделать?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {
            (action: UIAlertAction!) -> Void in
            
            
        })
        let anonimreg = UIAlertAction(title:  "Запрос", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
           
                             // self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "camera") as? takephoto{
                    self.present(pageViewController, animated: true, completion: nil)
                    //
                    
           
            }
            // let indexPath = tableView.indexPathForSelecte
        })
        
        let share = UIAlertAction(title:  "Заработать бонусы", style: .destructive, handler: {
            (action: UIAlertAction!) -> Void in
           // self.code="232"
           // self.updating()
            self.updating()
            let text = "\nПолучи запчасти бесплатно! Рекомендую приложение ABSauto \n1. Скачай приложение по ссылке https://itunes.apple.com/us/app/absauto/id1151032448?l=ru&ls=1&mt=8  \n2. Введи мой ПРОМОКОД "
            
            //рассказать друзьям
            let myWebsite = NSURL(string: "https://itunes.apple.com/us/app/absauto/id1151032448?l=ru&ls=1&mt=8")
            let vc = UIActivityViewController(activityItems: ["ПРОМОКОД - " + self.code! + text + self.code! + " - получишь бонусы! \n3. Приходи в ABSauto и предъявляй купоны прямо с экрана телефона!" ], applicationActivities: nil)
            self.present(vc,animated: true, completion: nil)
        }
        )
            let bonus = UIAlertAction(title:  "Ввести промо-код", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
                
                
                self.Codetext.addTarget(self, action: #selector(self.textFieldDidChanged(_:)), for: .editingChanged)
                
                self.PhoneNumber = (Auth.auth().currentUser?.phoneNumber!)!
                var ref: DatabaseReference!
                ref = Database.database().reference()
               
                ref.child("Users").child(self.PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    self.Bonus = value?["Bonus"] as? String ?? ""
                    self.CodeInBase = value?["Code"] as? String ?? ""
                    //  let user = User.init(username: username)
                    
                    //print("Bonus",)
                    //self.bonus.text = bonusVal+" Б"
                    
                    self.code = self.CodeInBase
                    self.Yourbonus.text! = String(self.Bonus)+" Б"
                    
                    
                    // ...
                }) { (error) in
                    //print(error.localizedDescription)
                    print ("notInBase")
                }
            self.visualeffect.alpha = 1
            self.loading.layer.cornerRadius = 15
            self.view.addSubview(self.loading)
            self.loading.center = self.view.center
           
            self.loading.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.5)
            {
                self.visualeffect.effect = self.effect
                self.loading.transform = CGAffineTransform.identity
            }
           
            
            self.PhoneNumber = (Auth.auth().currentUser?.phoneNumber!)!
            
            // поределение code
            
            print("PHONE ",self.PhoneNumber)
            
            //var posts = [CKRecord]()
           
               
       

            
            // let indexPath = tableView.indexPathForSelecte
        })

    //var isVisitedTitle =  "Сменить пользователя"
   //     optionMenu.addAction(isVisitedTitle)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(anonimreg)
       // if Auth
        if Auth.auth().currentUser?.phoneNumber == nil{
        }
        else
        {
        optionMenu.addAction(bonus)
        optionMenu.addAction(share)
        }
        
        
        //  optionMenu.addAction(callAction)
        
        self.present(optionMenu, animated: true, completion: nil)

    }
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        let tabbar = UITabBar()//if declare and initilize like this
        
        tabbar.selectedItem = tabBar.items?[1]   }
            // self.tabBar.selectedItem =  }
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
           // print(logoutError)
        }
        
        //...
    }
    @IBAction func exit(_ sender: AnyObject) {
        handleLogout()
       self.performSegue(withIdentifier: "loginView", sender: self)
    }
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "bonus"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 3
            }
        }
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField)
    {
        if self.Codetext.text!.characters.count == 10
        {
            activate()
        }
    }
    
    
    
    
    
    
}
