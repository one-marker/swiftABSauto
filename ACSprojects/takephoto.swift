//
//  takephoto.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 27.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI
import Firebase

class takephoto: UIViewController, UIImagePickerControllerDelegate, MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var list: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBAction func sendMMS(_ sender: Any) {
        self.text = "Номер телефона: " + phone.text! + "  Необходимые запчасти: " + (list?.text)!
      //  let mailComposeViewController = self.configuredMailComposeViewController()
        let  messageerror = UIAlertController(title: "Вы не заполнили форму", message: "Вы не указали свой номер телефон и список необходимых деталей", preferredStyle: .alert)
        messageerror.addAction(UIAlertAction(title: "Заполнить", style: .default, handler: { (action:UIAlertAction) -> Void in
            
        }
            ))
        if ((phone.text?.characters.count)!>5 && (list?.text?.characters.count)!>5)
        {
            self.sendSMS()
            
            // if MFMailComposeViewController.canSendMail() {
            //self.present(mailComposeViewController, animated: true, completion: nil)
            //} else {
            //  self.showSendMailErrorAlert()
            //}
            
        }
        else
            
        {
           self.present(messageerror, animated: true, completion: nil)
            print("error")
        }

    }
    @IBOutlet weak var visualeffect: UIVisualEffectView!
    var effect:UIVisualEffect!
    //@IBOutlet weak var visualeffect: UIView!
   // @IBOutlet weak var effect: UIVisualEffectView!
    @IBAction func ButtonOfContainer(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.ViewContainerForm.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.visualeffect.effect = nil
           // effect = visualeffect.effect
           // visualeffect.effect = nil
            self.visualeffect.alpha = -1
        })
        {(success:Bool) in
            
            self.ViewContainerForm.removeFromSuperview()
            
        }
    }
    
    @IBOutlet var ViewContainerForm: UIView!
    var status = 0
    @IBOutlet var tempImageView: UIImageView!
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCaptureStillImageOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
var text=""
    @IBAction func takephoto(_ sender: AnyObject) {
        
      
        if let videoConnection = sessionOutput.connection(withMediaType: AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            sessionOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider(data: imageData as! CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    self.imagev.image = image
                    self.imagev.layer.cornerRadius = 10.0
                    self.imagev.clipsToBounds = true
                  
                    var text2: UITextField?
                    self.ViewContainerForm.layer.cornerRadius = 15
                    self.view.addSubview(self.ViewContainerForm)
                    self.ViewContainerForm.center = self.view.center
                    self.visualeffect.alpha = 1
                    self.ViewContainerForm.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                    UIView.animate(withDuration: 0.5)
                    {
                        self.visualeffect.effect = self.effect
                                self.ViewContainerForm.transform = CGAffineTransform.identity
                        
                        if Auth.auth().currentUser?.phoneNumber == nil
                        {
                           
                        }
                        else
                        {
                            self.phone.text! = (Auth.auth().currentUser?.phoneNumber)!
                            
                        }
                     
                    }

                    /*
                     let alert = UIAlertController(title: "Введите свой телефон", message: "Укажите номер телефона для оперативной связи с Вами", preferredStyle: .alert)
                   let  messageerror = UIAlertController(title: "Вы не заполнили форму", message: "Вы не указали свой номер телефон и список необходимых деталей", preferredStyle: .alert)
                    messageerror.addAction(UIAlertAction(title: "Заполнить", style: .default, handler: { (action:UIAlertAction) -> Void in
                    
                    
                        self.present(alert, animated: true, completion: nil)

                    
                    
                    }
                    )
                    )

                   
                    alert.addTextField { (textField:UITextField) -> Void in
                        textField.placeholder = "Телефон для обратной связи "
                        textField.text = "+7"
                    }
                    alert.addTextField { (textField1:UITextField) -> Void in
                        text2 = textField1
                        textField1.placeholder = "Необходимые детали"
                    }

                    alert.addAction(UIAlertAction(title: "Отправить", style: .default, handler: { (action:UIAlertAction) -> Void in
                        let textField1 = alert.textFields!.first!
                        
                        let textField2 = text2?.text
                        
                       self.text = "Номер телефона: " + textField1.text! + "  Необходимые запчасти: " + (text2?.text)!
                             let mailComposeViewController = self.configuredMailComposeViewController()
                        
                        if ((textField1.text?.characters.count)!>5 && (text2?.text?.characters.count)!>5)
                       {
                        self.sendSMS()

                                                       // if MFMailComposeViewController.canSendMail() {
                                //self.present(mailComposeViewController, animated: true, completion: nil)
                            //} else {
                              //  self.showSendMailErrorAlert()
                            //}

                        }
                        else
                        
                       {
                         self.present(messageerror, animated: true, completion: nil)
                        print("error")
                        }
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    */

                                    // captureSession.stopRunning()
                }
            })
        }
        
    }
    
    @IBAction func hidekeyboard(_ sender: Any) {
        ViewContainerForm.endEditing(true)
        
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
      
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue: status = 0
            break
        case MessageComposeResult.failed.rawValue:
            let alertMessage = UIAlertController(title: "Failure", message: "Failed to send the message", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue: status = 1
        default: break
        }
        dismiss(animated: true, completion: nil)
        
   
//GoToStart
        if status == 1 {
            status = 0
        let alert1 = UIAlertController(title:"Запрос отправлен", message:"В ближайшее время он будет обработан и с Вами свяжутся", preferredStyle:UIAlertControllerStyle.alert);
        
        alert1.addAction(UIAlertAction(title: "ОК", style: .default, handler: {
            (action:UIAlertAction) -> Void in

               self.performSegue(withIdentifier: "GoToStart", sender: self)
        }))
        
        self.present(alert1, animated:true, completion:nil)
        }
    }

    
    //ммс
    
    func sendSMS() {
        guard MFMessageComposeViewController.canSendText() else {
            let alertMessage = UIAlertController(title: "SMS Unavailable", message: "Your device is not capable of sending SMS", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            return
        }
        
        let messageController = MFMessageComposeViewController()
      messageController.messageComposeDelegate = self
        
        //let fileparts = attachment.components(separatedBy: ".")
        //let filename = fileparts[0]
        //let fileExtension = fileparts[1]
        //let filePath = Bundle.main.path(forResource: filename, ofType: fileExtension)
        //let fileURL = URL(fileURLWithPath: filePath!)
        if let image = imagev.image {
            let data = UIImageJPEGRepresentation(image, 1.0)
             messageController.addAttachmentData(data!, typeIdentifier: "image/jpg", filename: "image.jpg")
        }
       // messageController.addAttachmentURL(fileURL, withAlternateFilename: nil)
        
       // messageController.setSubject("Запрос с мобильного приложения ABSauto от")

        messageController.recipients = ["79272367772"]
        messageController.body = "Запрос с мобильного приложения ABSauto от "+"\n"+text
        
        present(messageController, animated: true, completion: nil)
       // dismiss(animated: true, completion: nil)

    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagev.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func info(_ sender: AnyObject) {
      //  let userDefaults = NSUserDefaults.standardUserDefaults()
        // let displayedWalkthrough = userDefaults.boolForKey("DisplayedWalkthrough")
        
        // if we haven't shown the walkthroughs, let's show them
        //   if !displayedWalkthrough {
        // instantiate neew PageVC via storyboard
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController1") as? PageViewController1 {
            self.present(pageViewController, animated: true, completion: nil)
            // }
        }

        //UITabBarItem.selectite
      //  tabbar.selectedViewController = tabBarController.viewControllers![newIndex] as! UIViewController
       // tabBar.selectedItem = tabBar.items![1] as! UITabBarItem
       // let tabbar = UITabBar()//if declare and initilize like this
       //
       // tabbar.selectedItem = tabbar.items![0] as? UITabBarItem
        //tabBar.selectedIndex = 4// l
    }

    @IBOutlet var imagev: UIImageView!
    
    
    
    override func viewDidLoad(){
       //Трансляции камеры на imageview
        effect = visualeffect.effect
        visualeffect.effect = nil
        visualeffect.alpha = -1
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        
        for device in devices! {
           
            if (device as AnyObject).position == AVCaptureDevice.Position.back{
                do {
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input){
                        captureSession.addInput(input)
                        sessionOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                        if captureSession.canAddOutput(sessionOutput){
                            captureSession.addOutput(sessionOutput)
                            captureSession.startRunning()
                           // captureSession.addOutput(sessionOutput)
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                            tempImageView.layer.addSublayer(previewLayer)
                            
                            previewLayer.position = CGPoint(x: self.tempImageView.frame.width / 2, y: self.tempImageView.frame.height / 2)
                            
                            previewLayer.bounds = tempImageView.frame
                        }
                        
                    }
                    
                }
                catch
                {
                    //print ("error")
                }
            }
        }

        
          }
    override var prefersStatusBarHidden : Bool {
        return true
    }

    
    @IBAction func sendEmailButtonTapped(_ sender: AnyObject) {
        
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
            
        } else {
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        
         var mail: (String?) = "Не зарегистрированого пользоветеля"
            mail = Auth.auth().currentUser?.email
        if mail == ""
        {
            print("error")
        }
        
               let mailComposerVC = MFMailComposeViewController()
     //   mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(["79272367772@mail.ru"])
        mailComposerVC.setSubject("Запрос с мобильного приложения ABSauto от")
        mailComposerVC.setMessageBody(text, isHTML:
            false)
        
        //Add Image as Attachment
        if let image = imagev.image {
            let data = UIImageJPEGRepresentation(image, 1.0)
            mailComposerVC.addAttachmentData(data!, mimeType: "image/jpg", fileName: "image.jpg")
        }
        
        return mailComposerVC
    }
    
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    
   // func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWith result: MFMailComposeResult, /error: Error!) {
 //       controller.dismiss(animated: true, completion: nil)
//    }
    
    

    
}
