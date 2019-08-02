//
//  RideInfoVC.swift
//  Bounce
//
//  Created by Prithviraj Murthy on 18/07/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RideInfoVC: UIViewController {

    @IBOutlet weak var bookNow: UIButtonX!
    @IBOutlet weak var estimatedPrice: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    
    var price : String!
    var ArrivalTime : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      bookNow.setGradientBackground(colorOne: Colors.black, colorTwo: Colors.orange)
        
        estimatedPrice.text = price
        arrivalTime.text = ArrivalTime
    }
    
    @IBAction func bookNow(_ sender: Any) {
        alertTheUser(title: "Hey there!", message: "Your Booking is Confirmed")
    }
    @IBAction func bookLater(_ sender: Any) {
        alertTheUser(title: "Hey there!", message: "Your Booking is Confirmed. Vehicle will arrive at your current location on time.")
    }
    
    func alertTheUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "Main", sender: self)
//            self.dismiss(animated: true, completion: nil)

        }))
        self.present(alert, animated: true, completion: nil)
    }
}
