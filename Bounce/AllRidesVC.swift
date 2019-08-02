//
//  AllRidesVC.swift
//  Bounce
//
//  Created by Prithviraj Murthy on 20/07/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit

class AllRidesVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
    
    @IBOutlet weak var allRides: UITableView!
    
    var time = ["Book at 7:15 pm","Book at 7:30 pm","Book at 7:45 pm","Book at 8:00 pm"]
    var arrivalTime = ["Arrival time : 8:20 pm","Arrival time : 8:05 pm","Arrival time : 8:15 pm","Arrival time : 8:30 pm"]
    var travelTime = ["Travel time: 40 minutes","Travel time: 35 minutes","Travel time: 30 minutes","Travel time: 30 minutes"]
    var estimatedPrice = ["Estimated Price: Rs. 305","Estimated Price: Rs. 285","Estimated Price: Rs. 270","Estimated Price: Rs. 265"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        allRides.delegate = self
        allRides.dataSource = self
        allRides.clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! infoCell
        cell.bookTime.text = time[indexPath.row]
        cell.arrivalTime.text = arrivalTime[indexPath.row]
        cell.travelTime.text = travelTime[indexPath.row]
        cell.estimatedPrice.text = estimatedPrice[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: self)
        //        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "main" {
//            let indexPath = self.allRides.indexPathForSelectedRow
//            let VC = segue.destination as! ViewController
//            VC.newEstimatedPrice = estimatedPrice[(indexPath?.row)!]
//            VC.newArrivalTime = arrivalTime[(indexPath?.row)!]
//            VC.newInfo = true
//        }
        
        if segue.identifier == "details" {
            let VC = segue.destination as! RideInfoVC
            let indexPath = self.allRides.indexPathForSelectedRow
            
            VC.price = estimatedPrice[(indexPath?.row)!]
            VC.ArrivalTime = "Arrival Time: \(arrivalTime[(indexPath?.row)!])"

        }
    }

}
