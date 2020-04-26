//
//  homeBottomNav.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 25/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase

class homeBottomNav: UIViewController {
    
    var ref: DatabaseReference!
    var currentUser:String?
    var level:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = Auth.auth().currentUser?.uid
        // Do any additional setup after loading the view.
        
        
        ref = Database.database().reference().child("SelfAsses").child(currentUser!)
        ref.keepSynced(true)
        
        levelOfInfection()
    }
    
    @objc func levelOfInfection(){
        ref.observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let symptoms = value?["symptoms"] as? Int ?? 0
            let disease = value?["disease"] as? Int ?? 0
            let activity = value?["activity"] as? String ?? "No"
            
            if symptoms > 0 && disease > 0 && activity == "Yes"{
                self.level = 3
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            if symptoms > 0 && disease == 0 && activity == "Yes"{
                self.level = 3
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            
            if symptoms > 0 && disease > 0 && activity == "No"{
                self.level = 2
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            if symptoms == 3 || symptoms == 2 && disease == 0 && activity == "No" {
                self.level = 2
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            if symptoms == 0 && disease == 0 && activity == "Yes"{
                self.level = 2
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            if symptoms == 0 && disease > 1 && activity == "Yes"{
                self.level = 2
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            
            if symptoms == 0 && disease == 0 && activity == "No"{
                self.level = 1
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            
            if symptoms == 0 && disease > 0 && activity == "No"{
                self.level = 1
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }

            if symptoms == 1 && disease == 0 && activity == "No"{
                self.level = 1
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }
            
            if symptoms == 1 && disease == 1 && activity == "No"{
                self.level = 1
                self.displayAlertMessage(title: "Level", message: "\(self.level)")
            }

            print("Naruto" , symptoms , disease , activity)
            
        }
    }
    

    @IBAction func logout(_ sender: Any) {
        URLCache.shared.removeAllCachedResponses()
                  
        try! Auth.auth().signOut()
                  
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    @objc func displayAlertMessage(title:String , message:String){
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
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
