//
//  MapView.swift
//  ACSproject
//
//  Created by Максим Евлентьев on 22.07.16.
//  Copyright © 2016 Максим Евлентьев. All rights reserved.
//
//
//  ViewController.swift
//  MapOnFly
//
//  Created by p1us on 27.09.15.
//  Copyright © 2015 Ivan Akulov. All rights reserved.
//

import UIKit
import MapKit


class MapView: UIViewController {
    
    
    var geocoder: CLGeocoder!
    
    @IBOutlet var mapView: MKMapView!
    
    
    
   // @IBOutlet var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let string = "улица Менделеева, 187 Уфа, Республика Башкортостан, Россия"

       // textField.text =         // Do any additional setup after loading the view, typically from a nib.
        geocoder = CLGeocoder()
        
        //textField.addTarget(self, action: "textFieldDidChanged", forControlEvents: UIControlEvents.EditingChanged)
        geocoder.geocodeAddressString((string)) { (placemarks, error) -> Void in
            
            if error != nil {
              //  print("MapKit error \(error?.description)")
            }
            
            if placemarks != nil {
                if let placemark = placemarks?.first {
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = "Магазин автозапчастей  ABSauto"
                    annotation.subtitle = "улица Менделеева, 187 Уфа, Республика Башкортостан, Россия"

                    annotation.coordinate = placemark.location!.coordinate
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                }
            }
        }
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

