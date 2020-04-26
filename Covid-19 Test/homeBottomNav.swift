//
//  homeBottomNav.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 25/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class homeBottomNav: UIViewController {
    
    var ref: DatabaseReference!
    var refProfile:DatabaseReference!
    var currentUser:String?
    var level:Int = 0
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()


    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var webLoad: WKWebView!
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentUser = Auth.auth().currentUser?.uid
        // Do any additional setup after loading the view.
        
        indicatorViewStart()
        
        if let url = URL(string: "https://www.youtube.com/embed/9Ay4u7OYOhA"){
            webLoad.load(URLRequest(url: url))
        }
        
        

        ref = Database.database().reference().child("SelfAsses").child(currentUser!)
        refProfile = Database.database().reference().child("Users").child(currentUser!)
        ref.keepSynced(true)
        refProfile.keepSynced(true)
        genderIcon()
        levelOfInfection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func genderIcon(){
        
        refProfile.observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let gender = value?["Gender"] as? String
            
            if gender == "Male" {
                self.profileIcon.image = UIImage(named: "male")
            }else{
                self.profileIcon.image = UIImage(named: "female")
            }
            
        }
        
    }
    
    
    @objc func levelOfInfection(){
        ref.observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let symptoms = value?["symptoms"] as? Int ?? 0
            let disease = value?["disease"] as? Int ?? 0
            let activity = value?["activity"] as? String ?? "No"
            
            if symptoms > 0 && disease > 0 && activity == "Yes"{
                self.level = 3
                //self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.highInfection()
            } else
            if symptoms > 0 && disease == 0 && activity == "Yes"{
                self.level = 3
               // self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.highInfection()
            }else
            
            if symptoms > 0 && disease > 0 && activity == "No"{
                self.level = 2
              //  self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.medium()
            }else
            if symptoms == 3 || symptoms == 2 && disease == 0 && activity == "No" {
                self.level = 2
               // self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.medium()
            }else
            if symptoms == 0 && disease == 0 && activity == "Yes"{
                self.level = 2
             //   self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.medium()
            }else
            if symptoms == 0 && disease > 1 && activity == "Yes"{
                self.level = 2
             //   self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.medium()
            }else
            
            if symptoms == 0 && disease == 0 && activity == "No"{
                self.level = 1
              //  self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.lowInfection()
            }else
            
            if symptoms == 0 && disease > 0 && activity == "No"{
                self.level = 1
               // self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.lowInfection()

            }else

            if symptoms == 1 && disease == 0 && activity == "No"{
                self.level = 1
              //  self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.lowInfection()

            }else
            
            if symptoms == 1 && disease == 1 && activity == "No"{
                self.level = 1
              //  self.displayAlertMessage(title: "Level", message: "\(self.level)")
                self.lowInfection()

            }

            print("Naruto" , symptoms , disease , activity)
            
        }
    }
    

    
    
    @objc func lowInfection(){
        colorView.backgroundColor = .systemGreen
        status.text = "Low risk of infection"
        image1.image = UIImage(named: "social_distance")
        image2.image = UIImage(named: "temperature_check")
        lable1.text = "Maintain Social Distance"
        lable2.text = "Take Self assessment"
        indicatorViewStop()

    }
    @objc func medium(){
        colorView.backgroundColor = .orange
        status.text = "Medium risk of infection"
        image1.image = UIImage(named: "self_isolate")
        image2.image = UIImage(named: "get_tested")
        image2.contentMode = .scaleAspectFill
        lable1.text = "Isolate yourself"
        lable2.text = "Get yourself tested immediately"
        indicatorViewStop()


    }
    
    @objc func highInfection(){
        colorView.backgroundColor = .red
        status.text = "High risk of infection"
        image1.image = UIImage(named: "self_isolate")
        image2.image = UIImage(named: "get_tested")
        image2.contentMode = .scaleAspectFill
        lable1.text = "Isolate yourself"
        lable2.text = "Get yourself tested immediately"
        indicatorViewStop()

    }
    
    
    
    @objc func displayAlertMessage(title:String , message:String){
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
       }
    
    @objc func indicatorViewStart(){
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.style = UIActivityIndicatorView.Style.large
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                self.view.isUserInteractionEnabled = false
            }
            
            @objc func indicatorViewStop(){
                activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
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
