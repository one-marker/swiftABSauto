//
//  TableViewControllerADD.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 04.12.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase
import CloudKit
class TableViewControllerMENU: UITableViewController {
    var ref: DatabaseReference!
    var bonusVal = ""
    var PhoneNumber  = ""
    var StatusUser = ""
    var DateOfCrad = ""
    @IBOutlet var aimateview: UIView!
    
    @IBOutlet var visualeffect: UIVisualEffectView!
    @IBAction func button_action_message(_ sender: Any) {
    }
    var points = "-"
    let publicDatabase = CKContainer.default().publicCloudDatabase
    @IBAction func go(_ sender: Any) {
         self.performSegue(withIdentifier: "go", sender: self)
    }
    var images = [UIImage(named:"share.png"),UIImage(named:"oil-card1.png"),UIImage(named:"air1.png"),UIImage(named:"salon1.png")]
 var link = ["","5","10","15"]
    var price = [0,5,10,15]
     //   ["pictureOnePas", "pictureTwoPas", "pictureThreePas","camera1"]
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.addSubview(aimateview)
        
        
        if Auth.auth().currentUser?.phoneNumber == nil        {
        
        let alert = UIAlertController(title:"Вы не авторизовались", message:"Перейдите в наcтройки, чтобы авторизоваться", preferredStyle:UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "Перейти в настройки", style: .default, handler: {(action: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "Auth", sender: self)
            
            //print("buy succsesful")
            
        })
            
        )
        
        self.present(alert, animated:true, completion:nil)
        }
        else
        {
        
        update()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
               // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func refresh(_ sender: Any) {
       // let timestamp: NSNumber = NSNumber(Int(NSDate().timeIntervalSince1970))
        tableView.reloadData()

                 refreshControl?.endRefreshing()
   
    }
    func buy()
    {
        update()
        
    }
    var publicbonus = ""
    
    func update()
    {
        PhoneNumber = (Auth.auth().currentUser?.phoneNumber)!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(PhoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.bonusVal = value?["Bonus"] as? String ?? ""
            self.StatusUser = value?["Status"] as? String ?? ""
            self.DateOfCrad = value?["Date"] as? String ?? ""
            
            //  let user = User.init(username: username)
            
            print("Bonus",self.bonusVal)
            print(self.StatusUser)
            print(self.DateOfCrad)
            self.publicbonus = String(self.bonusVal)
            //self.bonus.text = bonusVal+" Б"
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
            print ("notInBase")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }
  override var prefersStatusBarHidden : Bool {
        return true
    }
    var header : CGFloat = 67
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return header
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       // let headerView = Bundle.main.loadNibNamed("HeaderViewTableViewCell", owner: self, options: nil)?.first as!HeaderViewTableViewCell
     //   return headerView
        let headerView = tableView.dequeueReusableCell(withIdentifier: "Header") as!  HeaderViewTableViewCell
        // let cellIdentifier = "cell3"
        // let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TableViewCell2      // Configure the cell...
        
        //  return cell
        
        return headerView

    }
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cellIdentifier = "cell1"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!  TableViewCellMENU
        
        
        
        //cell.name = array[indexPath.row]
        
        //
        //print(s)
        
        // self.view.addSubview(imageView)
        
        
        // print("GOOG")
        // cell.photo.layer.cornerRadius = 15.0
        //   cell.photo.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
       
        
         cell.imag.image=images[indexPath.row]
       // cell.imag.im
        
        return cell
        
        

    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //  check_buy()
        self.update()
        print("rowselect")
        var indexPath = tableView.indexPathForSelectedRow
   //var price1 = price[indexPath]
        tableView.deselectRow(at: indexPath!, animated: true)
        //if self.points != "-"
       // {
      //  check_buy()
        let timestampDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        print(indexPath?.row)
        var time = dateFormatter.string(from: timestampDate as Date)
       // print("data", time)

           
       // update()
               //let destinationVC: image = segue.destinationViewController as! image
       // let list = array[(indexPath! as NSIndexPath).row]
  
        if indexPath?.row != 0
        {
            
   
   // var web = link[(indexPath?.row)!]
  //  var escapedAddress = web.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
    
    let optionMenu = UIAlertController(title: nil, message: "При использование купона он появиться у вас в разделе мои купоны. Купон будет активен до окончания "+time, preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {
        (action: UIAlertAction!) -> Void in
        
        
    })
            var price1 = self.price[(indexPath?.row)!]

    let isVisitedTitle =  "Воспользоваться купоном"
    
    let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .destructive, handler: {
        (action: UIAlertAction!) -> Void in
        
        self.update()
        if (self.StatusUser == "0")
        {
        // var indexPath = tableView.indexPathForSelectedRow
        //var indexPath1 = tableView.indexPathForSelectedRow

   
        
        let headerView = Bundle.main.loadNibNamed("HeaderViewTableViewCell", owner: self, options: nil)?.first as! HeaderViewTableViewCell
    
            
            
            var b: Int = Int(self.bonusVal)!
       
            if b >= price1
            {
               
                b=b-price1
                var b1 = String(b)
                print("Good "+b1)
                print("index ",indexPath?.row)
                var status: Int = (indexPath?.row)!
                var statusString: String = String(status)
                //запись в базу
                let UserPhone = self.ref.child("Users").child((Auth.auth().currentUser?.phoneNumber)!)
                
                let Status = UserPhone.child("Status")
                Status.setValue(statusString)
                
                let Date = UserPhone.child("Date")
                Date.setValue(time)
                
                let BonusAfter =  UserPhone.child("Bonus")
                BonusAfter.setValue(b1)
                
                
                
                
                let alert = UIAlertController(title:"Покупка совершена", message:"С вашего счета списано "+String(price1
                    )+" бонусов", preferredStyle:UIAlertControllerStyle.alert);
                alert.addAction(UIAlertAction(title: "Посмотреть купон", style: .default, handler: {(action: UIAlertAction!) -> Void in
               self.performSegue(withIdentifier: "go", sender: self)
                    
                    print("buy succsesful")
                    
                })
                    
                )
                
                self.present(alert, animated:true, completion:nil)
                      //  tableView.reloadData()
                        //self.check_buy()
                        
                
                
            }
            else
            {
                let alert1 = UIAlertController(title:"Ошибка", message:"На вашем счету нет "+String(price1
                    )+" бонусов", preferredStyle:UIAlertControllerStyle.alert);
                alert1.addAction(UIAlertAction(title: "Хорошо, я ещё подкоплю", style: .default, handler:{(action: UIAlertAction!) -> Void in
                //    self.performSegue(withIdentifier: "go", sender: self)
                    
                    // print("buy succsesful")
                    
                    
                    
                })
                    
                )
                self.present(alert1, animated:true, completion:nil)
            }
          

           
        
      
        }
        else{
            let alert = UIAlertController(title:"Вы уже используете купон", message:"Подождите пока истечет срок действия купона", preferredStyle:UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "Хорошо, я подожду", style: .default, handler: {(action: UIAlertAction!) -> Void in
                //  self.performSegue(withIdentifier: "go", sender: self)
                
                
                
                
            })
                
            )
            self.present(alert, animated:true, completion:nil)

        }
    })
    
    
    // let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .Default, handler: callActionHandler)
    
    
    
   
    
        optionMenu.addAction(cancelAction)
        //  optionMenu.addAction(callAction)
        optionMenu.addAction(isVisitedAction)
        self.present(optionMenu, animated: true, completion: nil)
    
        
        }
        else{
            self.performSegue(withIdentifier: "share", sender: self)

        }
    
       // }
      // else{
          
        //}
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
     MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
