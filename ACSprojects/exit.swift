//
//  exit.swift
//  ABSauto
//
//  Created by Максим Евлентьев on 28.08.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import Firebase


class exit: UIViewController {
   
   var link: String?
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func viewDidAppear(_ animated: Bool) {
        
       
        var mail: (String?) = ""
        var info = "\nПодтвердите смену пользователя приложения на данном устройстве."
      //  mail  = "Не зарегистрированный пользователь"

        if Auth.auth().currentUser?.phoneNumber == nil
        {
            info="Авторизоваться с помощью телефона"
                    }
        else{
            
            mail = (Auth.auth().currentUser?.phoneNumber)!         }
       
        
        //var title = "Пользоветль: "
        let optionMenu = UIAlertController(title: nil, message: mail! + info, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler:{
            (action: UIAlertAction!) -> Void in

            
            
            //cancel
            
            
            if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "tab") as? UITabBarController{
                self.present(pageViewController, animated: true, completion: nil)
                // }
            }

        })
      
        
        let anonimreg = UIAlertAction(title:  "Зарегистрироваться", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            do{
                try Auth.auth().signOut()
                // self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "register") as? FirstView{
                    self.present(pageViewController, animated: true, completion: nil)
                    //  }
                    
                }       }
            catch let error as NSError
            {
                
            }
            
            // let indexPath = tableView.indexPathForSelecte
        })
        var isVisitedTitle =  "Сменить пользователя"
        if Auth.auth().currentUser?.isAnonymous == true{
            isVisitedTitle =  "Авторизоваться"
        }
        else
        {
        isVisitedTitle =  "Сменить пользователя"
        }
        
        let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .destructive, handler: {
            (action: UIAlertAction!) -> Void in
            // let indexPath = tableView.indexPathForSelectedRow
           

            self.exit()
            
            
            //     let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            //  self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
            //
            // cell?.accessoryType = (self.restaurantIsVisited[indexPath.row]) ? .Checkmark : .None
        })
        
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Сервис недоступен", message: "Простите, но сейчас позвонить невозможно. Повторите позже", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                       self.present(alertMessage, animated: true, completion: nil)
        }
        
        // let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .Default, handler: callActionHandler)
        
        
        optionMenu.addAction(cancelAction)
        
        //  optionMenu.addAction(callAction)
        optionMenu.addAction(isVisitedAction)
          if Auth.auth().currentUser?.isAnonymous == true{
            // optionMenu.addAction(anonimreg)
        }
       self.present(optionMenu, animated: true, completion: nil)
      
           // print(FIRAuth.auth()?.currentUser?.email)
      
        
    }
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        //...
    }
    func exit() {
        
        if Auth.auth().currentUser != nil
        {
            do{
                try Auth.auth().signOut()
               // self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as? ViewController{
                      self.present(pageViewController, animated: true, completion: nil)
                    //  }
                    
                }       }
            catch let error as NSError
            {
                
            }
            
        }
            
        
 ///  handleLogout()
            //self.performSegueWithIdentifier("loginv", sender: self)

     // if let pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("login") as? ViewController{
      //   self.presentViewController(pageViewController, animated: true, completion: nil)
          //  }
        
     //  handleLogout()
    }
    


}
