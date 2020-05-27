//
//  tableViewController.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 23.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//
import UIKit
import Foundation
import Firebase
import CloudKit


class tableViewController: UITableViewController {
   
   // var refresh:UIRefreshControl!
    var a = 1
   
    
    @IBAction func refresh(_ sender: AnyObject) {
        tableView.reloadData()
    }
       var sweets = [CKRecord]()
   // var refresh:UIRefreshControl!

    
    var s = ""
    //@IBOutlet var tableView: UITableView!
    var array = [ADD]()
       var array2 = [String]()
       // var names = ["Качаство в деталях","Сервисные пакеты","KAYABA"]
       var images = [UIImage(named:"first.png"),UIImage(named:"second.jpg"),UIImage(named:"third.bmp")]
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    @IBAction func send(_ sender: AnyObject) {
       // let alert = UIAlertController(title: "New Sweet", message: "Enter a sweet", preferredStyle: .alert)
        loadData()
    }
    
    func loadData () {
        
        sweets = [CKRecord]()
        
        //var arrNotes: Array<CKRecord> = []
            let container = CKContainer.default()
            let privateDatabase = container.publicCloudDatabase
            let predicate = NSPredicate(value:true)
            
            let query = CKQuery(recordType: "News", predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (results, error) in
            
            if error != nil {
               print (error)
            }
            if let results = results
            {
                self.sweets = results
                print(results)
                
            }
        }
     //  print(sweets)
        
        }
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void)
    {
       
    }
    func firebase()
    {
         }
  

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //firebase()
      
                 self.array = []
               //   refresh = UIRefreshControl()
    //    refresh.attributedTitle = NSAttributedString(string: "Потяните вниз для обновления страницы")
     //  refresh.addTarget(self, action: #selector(tableViewController.firebase), for: .valueChanged)

       //self.tableView.addSubview(refresh)
       //
        
firebase()
        
      //UITabBar.appearance().barTintColor = UIColor.blackColor()

    
     //refreshControl?.isEnabled = false
       // firebase()
             // let rootref = FIRDatabase.database().reference()
       
       // self.view.addSubview(imageView)
        
      //  refresh.endRefreshing()
       // loadData()
        
        
       // self.navigationController!.navigationBar.barTintColor = UIColor.greenColor()
        
        //imageView.backgroundColor = UIColor.orangeColor()
        
        
        //firebase()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
       // firebase_first()
       // firebase()
    }
   //override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     //   return "Меню"
    //}
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let img = CustomCell()
        if img.mage == nil {
            //print("ok")
        }
        else{
        //print("no")
        }
        
    
        
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!  CustomCell
        
        
      
        //cell.name = array[indexPath.row]
        
        //
        //print(s)
        
        // self.view.addSubview(imageView)
        
       
           // print("GOOG")
       // cell.photo.layer.cornerRadius = 15.0
             //   cell.photo.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        cell.active.startAnimating()
        let list = array[(indexPath as NSIndexPath).row]
       // cell.textLabel?.text = user.name
      //  cell.detailTextLabel?.text = user.email
       cell.photo.loadImageUsingCacheWithUrlString(urlString: list.img1!)
        //cell.photo.layer.masksToBounds = true
        //cell.photo.layer.borderWidth = 1

        refreshControl?.endRefreshing()

           // let url = NSURL(string: list.img1!)
            
          //  let session = NSURLSession.sharedSession()
            
           // let task = session.downloadTaskWithURL(url!)
                
          //  {
          //
           //     (url: NSURL?, res: NSURLResponse?, e: NSError?) in
                
           //     let d = NSData(contentsOfURL: url!)
                
            //    let image1 = UIImage(data: d!)
                
                
                
           //     dispatch_async(dispatch_get_main_queue()) {
                    
           //         cell.photo.image = image1
           //
                   // img.mage = image1

           //
           //     }
        //     cell.active.hidden=true
           // }
            
         //   task.resume()
        
        //cell.photo.layer.cornerRadius = 10.0
       // cell.photo.clipsToBounds = true
        


       // let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!
        
      // cell.photo.image=images[indexPath.row]
      
        return cell
        

        
        }
    
   

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        //let destinationVC: image = segue.destinationViewController as! image
        let list = array[(indexPath! as NSIndexPath).row]
        let web = list.link!

        let optionMenu = UIAlertController(title: nil, message: "Что вы хотите сделать?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {
            (action: UIAlertAction!) -> Void in

            tableView.deselectRow(at: indexPath!, animated: true)

        })
        
        let isVisitedTitle =  "Перейти по ссылке"
        
        let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .default, handler: {
            (action: UIAlertAction!) -> Void in
                        // let indexPath = tableView.indexPathForSelectedRow
            if let requestUrl = URL(string: web) {
                UIApplication.shared.openURL(requestUrl)
            }
            

            
       //     let cell = tableView.cellForRowAtIndexPath(indexPath)
            
          //  self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
          //
           // cell?.accessoryType = (self.restaurantIsVisited[indexPath.row]) ? .Checkmark : .None
        })
        
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Сервис недоступен", message: "Простите, но сейчас позвонить невозможно. Повторите позже", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
           

        }
        
       // let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .Default, handler: callActionHandler)
        
        
        optionMenu.addAction(cancelAction)
      //  optionMenu.addAction(callAction)
        optionMenu.addAction(isVisitedAction)
        self.present(optionMenu, animated: true, completion: nil)
           }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabbar = UITabBar()//if declare and initilize like this
        
        tabbar.selectedItem = tabbar.items![0] as? UITabBarItem       // let cell = tableView.dequeueReusableCellWithIdentifier("cell", //forIndexPath: indexPath) as!  CustomCell
        
        // if segue.identifier == "showDetail" {
     //   let indexPath = tableView.indexPathForSelectedRow
        
      //  let destinationVC: image = segue.destinationViewController as! image
      //  var list = array[indexPath!.row]
      ///  var web = list.link!
      //     // let indexPath = tableView.indexPathForSelectedRow
       // if let requestUrl = NSURL(string: web) {
       //     UIApplication.sharedApplication().openURL(requestUrl)
      //  }

       //destinationVC.textOfLabel = list.img1!
        //    destinationVC.linkoflink = list.link!
            //destinationVC.uimage.image =
           // let cellIdentifier = "cell"
       //     let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: list.a) as!  CustomCell

        
            }

    //
  
   override var prefersStatusBarHidden : Bool {
        return true
    }
    
       //
     
}
