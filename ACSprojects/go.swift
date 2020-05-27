//
//  go.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 16.12.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase
import CloudKit

class go: UIViewController {
    @IBOutlet weak var infoimage: UIImageView!
    var ref: DatabaseReference!
    var PhoneNumber  = ""
    var StatusUser = ""
    var DateOfCard = ""
    let publicDatabase = CKContainer.default().publicCloudDatabase
   var images = [UIImage(named:"YouDontHaveKypon.png"),UIImage(named:"oil-card1.png"),UIImage(named:"air1.png"),UIImage(named:"salon1.png")]
    
    
    func update()
    {
        PhoneNumber = (Auth.auth().currentUser?.phoneNumber)!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
          //  self.bonusVal = value?["Bonus"] as? String ?? ""
            self.StatusUser = value?["Status"] as? String ?? ""
            self.DateOfCard = value?["Date"] as? String ?? ""
            
            //  let user = User.init(username: username)
            
           // print("Bonus",self.bonusVal)
            print(self.StatusUser)
            print(self.DateOfCard)
           // self.publicbonus = String(self.bonusVal)
            //self.bonus.text = bonusVal+" Б"
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
            print ("notInBase")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhoneNumber = (Auth.auth().currentUser?.phoneNumber)!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            //  self.bonusVal = value?["Bonus"] as? String ?? ""
            self.StatusUser = value?["Status"] as? String ?? ""
            self.DateOfCard = value?["Date"] as? String ?? ""
            
            //  let user = User.init(username: username)
            
            // print("Bonus",self.bonusVal)
            print("Status ",self.StatusUser)
            print("Date ",self.DateOfCard)
            
            
            if snapshot.exists() {
                print ("snapshot exist")
                //print (snapshot.childrenCount)
                print(self.DateOfCard)
                self.check()
            }
            else {
                print ("snapshot doesn't exist")
            }
           
            // self.publicbonus = String(self.bonusVal)
            //self.bonus.text = bonusVal+" Б"
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
            print ("notInBase")
        }
        
        
       
        

        
        
        
        // Do any additional setup after loading the view.
    }
    func check()
    {
        let timestampDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        var time = dateFormatter.string(from: timestampDate as Date)
        
        
        if StatusUser != "0"
        {
            
            if self.DateOfCard != time
            {
                print("Date "+self.DateOfCard)
                print("time " + time )
                let UserPhone = self.ref.child("Users").child(PhoneNumber)
                
                let phoneBase = UserPhone.child("Date")
                phoneBase.setValue("0")
                
                let bonus = UserPhone.child("Status")
                bonus.setValue("0")
                
                //
                
                let alert = UIAlertController(title:"Время вышло", message:"Срок действия купона закончился", preferredStyle:UIAlertControllerStyle.alert);
                alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: {(action: UIAlertAction!) -> Void in
                    //self.performSegue(withIdentifier: "goOut", sender: self)
                    
                    //    print("buy succsesful")
                    
                    
                    
                })
                    
                )
                self.present(alert, animated:true, completion:nil)
                
                self.kupon.image = self.images[0]
                
            }
            else{
                var index = Int(StatusUser)
                // index = index!/10
                self.kupon.image = self.images[index!]
                self.infoimage.image = UIImage(named:"info-1.png")
                self.date.text = "Купон действует до конца: " + DateOfCard
            }
            
        }
        else{
           self.kupon.image = self.images[0]
        }
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var kupon: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
