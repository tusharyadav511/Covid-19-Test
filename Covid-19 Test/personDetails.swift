//
//  personDetails.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 24/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class personDetails: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var Gender: UIButton!
    @IBOutlet var genderCollection: [UIButton]!
    
    @IBOutlet weak var profession: UIButton!
    @IBOutlet var professionCollection: [UIButton]!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nameError: UILabel!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var ageError: UILabel!
    
    @IBOutlet weak var genderError: UILabel!
    @IBOutlet weak var professionalError: UILabel!
    
    var ref: DatabaseReference!
    var currentUser:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentUser = Auth.auth().currentUser?.uid
        Gender.layer.cornerRadius = Gender.frame.height / 2
        genderCollection.forEach { (genderBtn) in
            genderBtn.layer.cornerRadius = genderBtn.frame.height / 2
            genderBtn.isHidden = true
        }
        
        profession.layer.cornerRadius = profession.frame.height / 2
        professionCollection.forEach { (professionBtn) in
            professionBtn.layer.cornerRadius = professionBtn.frame.height / 2
            professionBtn.isHidden = true
        }
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        
        ref = Database.database().reference().child("Users").child(currentUser!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == name{
            textField.resignFirstResponder()
            age.becomeFirstResponder()
        }
        return true
    }
    
    @IBAction func genderButton(_ sender: Any) {
        
            genderCollection.forEach { (genderBtn) in
                UIView.animate(withDuration: 0.4, animations: {
                    
                genderBtn.isHidden = !genderBtn.isHidden
                self.view.endEditing(true)
                self.view.layoutIfNeeded()
                 
                })
            }
       
    }
    @IBAction func genderSelected(_ sender: UIButton) {
        if let btnLable = sender.titleLabel?.text{
            
            Gender.titleLabel?.text = btnLable
            genderCollection.forEach { (genderBtn) in
                UIView.animate(withDuration: 0.4, animations: {
                    
                genderBtn.isHidden = !genderBtn.isHidden
                self.view.endEditing(true)
                self.view.layoutIfNeeded()
                 
                })
            }
            
        }
    }
    
    @IBAction func professionButton(_ sender: UIButton) {
        professionCollection.forEach { (professionBtn) in
            UIView.animate(withDuration: 0.4, animations: {
                professionBtn.isHidden = !professionBtn.isHidden
                 self.view.endEditing(true)
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    @IBAction func professionSelected(_ sender: UIButton) {
        
        if let btnLable = sender.titleLabel?.text{
            profession.titleLabel?.text = btnLable
            
            professionCollection.forEach { (professionBtn) in
                      UIView.animate(withDuration: 0.4, animations: {
                          professionBtn.isHidden = !professionBtn.isHidden
                         self.view.endEditing(true)
                          self.view.layoutIfNeeded()
                      })
                  }
        }
        
    }
    
    
    @IBAction func nextPressend(_ sender: UIButton) {
        checkDetails()
    }
    
    @objc func checkDetails(){
        
        if (name.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            nameError.text = "This field is required"
            ageError.text = ""
            genderError.text = ""
            professionalError.text = ""
        }else if ((age.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
            ageError.text = "This field is required"
            genderError.text = ""
            professionalError.text = ""
            nameError.text = ""
        }else if Gender.titleLabel?.text?.trimmingCharacters(in: .whitespaces) == "Gender" {
            genderError.text = "This field is required"
            nameError.text = ""
            ageError.text = ""
            professionalError.text = ""
        }else if profession.titleLabel?.text?.trimmingCharacters(in: .whitespaces) == "Profession"{
            professionalError.text = "This field is required"
            nameError.text = ""
            ageError.text = ""
            genderError.text = ""
        }else{
            firebaseStore(name: name, age: age, gender: Gender, profession: profession)
            nameError.text = ""
            ageError.text = ""
            genderError.text = ""
            professionalError.text = ""
            self.performSegue(withIdentifier: "detailBottomNav", sender: nil)
        }
    }
    
    @objc func displayAlertMessage(title:String , message:String){
                 let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                 alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(alertController, animated: true, completion: nil)
                 //self.indicatorViewStop()
             }
    
    @objc func firebaseStore(name:UITextField , age:UITextField , gender:UIButton , profession: UIButton){
        let name = name.text?.trimmingCharacters(in: .whitespaces)
        let age = age.text?.trimmingCharacters(in: .whitespaces)
        let gender = gender.titleLabel?.text?.trimmingCharacters(in: .whitespaces)
        let profession = profession.titleLabel?.text?.trimmingCharacters(in: .whitespaces)
        
        let personalData: [String : String] = ["Name" : name! , "Age" : age! , "Gender" : gender! , "Profession" : profession!]
        ref.setValue(personalData)
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
