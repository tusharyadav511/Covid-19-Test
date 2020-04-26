//
//  activitySelfAsses.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 25/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class activitySelfAsses: UIViewController {
    @IBOutlet weak var travelInternational: UIButton!
    @IBOutlet weak var nonOfTheAbove: UIButton!
    @IBOutlet weak var healthWorkers: UIButton!
    @IBOutlet weak var meatOtherPeople: UILabel!
    
    var ref: DatabaseReference!
    var currentUser:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Auth.auth().currentUser?.uid

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        meatOtherPeople.isUserInteractionEnabled = true
        meatOtherPeople.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
       
        ref = Database.database().reference().child("SelfAsses").child(currentUser!)

    }
    
    @IBAction func travel(_ sender: Any) {
        ref.child("activity").setValue("Yes")
        performSegue(withIdentifier: "bottomNav", sender: nil)
    }
    @IBAction func worker(_ sender: Any) {
        ref.child("activity").setValue("Yes")
        performSegue(withIdentifier: "bottomNav", sender: nil)
    }
    @IBAction func noneOfTheAbove(_ sender: Any) {
        ref.child("activity").setValue("No")
        performSegue(withIdentifier: "bottomNav", sender: nil)
    }
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
           ref.child("activity").setValue("Yes")
           performSegue(withIdentifier: "bottomNav", sender: nil)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
