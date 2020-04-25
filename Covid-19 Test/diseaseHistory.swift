//
//  diseaseHistory.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 25/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class diseaseHistory: UIViewController ,BEMCheckBoxDelegate  {

    @IBOutlet weak var nextScreen: UIButton!
    
    @IBOutlet weak var diabetes: BEMCheckBox!
    @IBOutlet weak var hypertension: BEMCheckBox!
    @IBOutlet weak var lungDisease: BEMCheckBox!
    @IBOutlet weak var heartDisease: BEMCheckBox!
    @IBOutlet weak var noneOfTheAbove: BEMCheckBox!
    
    var level:Int = 0

    var ref: DatabaseReference!
    var currentUser:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser?.uid

        // Do any additional setup after loading the view.
        diabetes.delegate = self
        hypertension.delegate = self
        lungDisease.delegate = self
        heartDisease.delegate = self
        noneOfTheAbove.delegate = self
        
        diabetes.onAnimationType = .fill
        hypertension.onAnimationType = .fill
        lungDisease.onAnimationType = .fill
        heartDisease.onAnimationType = .fill
        noneOfTheAbove.onAnimationType = .fill
        
        nextScreen.layer.cornerRadius = nextScreen.frame.height / 2

        ref = Database.database().reference().child("SelfAsses").child(currentUser!)
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.isTouchInside{
            nextScreen.isHidden = false
            nextScreen.isEnabled = true
        }
        
        if checkBox.tag == 4 {
            diabetes.isEnabled = false
            hypertension.isEnabled = false
            lungDisease.isEnabled = false
            heartDisease.isEnabled = false
            
            diabetes.isHidden = true
            hypertension.isHidden = true
            lungDisease.isHidden = true
            heartDisease.isHidden = true
        }else{
            diabetes.isEnabled = true
            hypertension.isEnabled = true
            lungDisease.isEnabled = true
            heartDisease.isEnabled = true
            noneOfTheAbove.isEnabled = false
            
            diabetes.isHidden = false
            hypertension.isHidden = false
            lungDisease.isHidden = false
            heartDisease.isHidden = false
            noneOfTheAbove.isHidden = true
        }
        
        if checkBox.tag == 0 {
            if diabetes.on{
               level = level + 1
            }else{
                level = level - 1
            }
        }
        
        if checkBox.tag == 1 {
            
            if hypertension.on{
                level = level + 1
            }else{
                level = level - 1
            }
        }
        if checkBox.tag == 2 {
            if lungDisease.on{
                level = level + 1
            }else{
                level = level - 1
            }
        }
        
        if checkBox.tag == 3 {
            if heartDisease.on{
                level = level + 1
            }else{
                level = level - 1
            }
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        ref.child("disease").setValue(level)
        self.performSegue(withIdentifier: "nextTravel", sender: nil)
        
    }
    
    
    @objc func displayAlertMessage(title:String , message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

     @IBAction func next(_ sender: Any) {
     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
