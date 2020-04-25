//
//  healthSymptoms.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 25/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class healthSymptoms: UIViewController  , BEMCheckBoxDelegate{
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cough: BEMCheckBox!
    @IBOutlet weak var fever: BEMCheckBox!
    @IBOutlet weak var difficultyInBreathing: BEMCheckBox!
    @IBOutlet weak var noneOfTheAbove: BEMCheckBox!
    var level:Int = 0
    
    var ref: DatabaseReference!
    var currentUser:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Auth.auth().currentUser?.uid
        cough.delegate = self
        fever.delegate = self
        difficultyInBreathing.delegate = self
        noneOfTheAbove.delegate = self
        
        cough.onAnimationType = .fill
        fever.onAnimationType = .fill
        difficultyInBreathing.onAnimationType = .fill
        noneOfTheAbove.onAnimationType = .fill
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        
        ref = Database.database().reference().child("SelfAsses").child(currentUser!)


        print("Health")
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.isTouchInside{
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }
        
        if checkBox.tag == 3 {
            cough.isEnabled = false
            fever.isEnabled = false
            difficultyInBreathing.isEnabled = false
            cough.isHidden = true
            fever.isHidden = true
            difficultyInBreathing.isHidden = true
        }else{
            cough.isEnabled = true
            fever.isEnabled = true
            difficultyInBreathing.isEnabled = true
            noneOfTheAbove.isEnabled = false
            
            cough.isHidden = false
            fever.isHidden = false
            difficultyInBreathing.isHidden = false
            noneOfTheAbove.isHidden = true
        }
        
        if checkBox.tag == 0 {
            if cough.on{
               level = level + 1
            }else{
                level = level - 1
            }
        }
        
        if checkBox.tag == 1 {
            
            if fever.on{
                level = level + 1
            }else{
                level = level - 1
            }
        }
        if checkBox.tag == 2 {
            if difficultyInBreathing.on{
                level = level + 1
            }else{
                level = level - 1
            }
        }
    }

    @IBAction func next(_ sender: Any) {
        ref.child("symptoms").setValue(level)
        self.performSegue(withIdentifier: "nextdisease", sender: nil)
    }
    // MARK: - Table view data source
    @objc func displayAlertMessage(title:String , message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
