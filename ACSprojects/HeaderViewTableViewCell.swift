//
//  HeaderViewTableViewCell.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 16.12.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase
import CloudKit

class HeaderViewTableViewCell: UITableViewCell {
    var ref: DatabaseReference!
    var PhoneNumber  = ""
    let publicDatabase = CKContainer.default().publicCloudDatabase
    @IBAction func go(_ sender: Any) {
        //TableViewCellMENU.update()
    }
    @IBAction func gotomycard(_ sender: Any) {
        //performSegue(withIdentifier: "loginView", sender: self)

    }
   // @IBOutlet weak var bonus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  bonus.text = "dd"
        //print("ok888888")
        update()

    }
    func update()
    {
        if Auth.auth().currentUser?.phoneNumber == nil        {
            
        }
        else
        {
        PhoneNumber = (Auth.auth().currentUser?.phoneNumber)!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var bonusVal = value?["Bonus"] as? String ?? ""
            //  let user = User.init(username: username)
            
            print("Phone",bonusVal)
            self.bonus.text = bonusVal+" Б"
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
            print ("notInBase")
        }
        }
        
       

    }
    @IBOutlet weak var bonus: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
