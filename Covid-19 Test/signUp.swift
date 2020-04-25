//
//  signUp.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 24/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import FirebaseAuth


class signUp: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var verifyPasswordError: UILabel!
    var cancel:Bool = false
    
    @IBAction func signUpAction(_ sender: Any) {
        signUp()
    }
    
    
    @IBOutlet weak var signUpButtonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        signUpButtonView.layer.cornerRadius = 15
        signUpButtonView.clipsToBounds = true
        // Do any additional setup after loading the view.
        
        emailAddress.addTarget(self, action: #selector(checkfield(txtField:)), for: .editingChanged)
              
        password.addTarget(self, action: #selector(checkfield(txtField:)), for: .editingChanged)
               
        verifyPassword.addTarget(self, action: #selector(checkfield(txtField:)), for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailAddress{
            textField.resignFirstResponder()
            password.becomeFirstResponder()
        }else if textField == password{
            textField.resignFirstResponder()
            verifyPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            signUp()
        }
        return true
    }
    
    @objc func checkfield(txtField:UITextField){
        
        if txtField.text?.count == 0 && txtField == emailAddress{
            emailError.text = "This field is required"
            cancel = true
        }else{
            emailError.text = ""
            cancel = false
            }
            
            if isValidEmail(email: txtField.text!) == false && txtField == emailAddress{
            emailError.text = "This email address is invalid"
            cancel = true
        }else{
            emailError.text = ""
            cancel = false
            }
            
        if txtField.text?.count == 0 && txtField == password{
            passwordError.text = "This field is required"
            cancel = true
        }else{
            passwordError.text = ""
            cancel = false
            }
            
        if txtField.text?.count ?? 0 <= 6 && txtField == password{
            passwordError.text = "This password is too short"
            cancel = true
        }else{
            passwordError.text = ""
            cancel = false
            }
            
        if txtField.text?.count == 0 && txtField == verifyPassword{
            verifyPasswordError.text = "This field is required"
            cancel = true
        }else{
            verifyPasswordError.text = ""
            cancel = false
            }
            
        if txtField.text != password.text && txtField == verifyPassword{
            verifyPasswordError.text = "Passwords do not match"
            cancel = true
        }else{
            verifyPasswordError.text = ""
            cancel = false
            }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc func attemSignUp(){
        
        if emailAddress.text?.count == 0 {
              emailError.text = "This field is required"
              cancel = true
          }else if emailAddress.text?.contains("@") == false{
              emailError.text = "This email address is invalid"
              cancel = true
          }else if password.text?.count == 0 {
              passwordError.text = "This field is required"
              cancel = true
          }else if password.text?.count ?? 0 <= 6 {
              passwordError.text = "This password is too short"
              cancel = true
          }else if verifyPassword.text?.count == 0 {
              verifyPasswordError.text = "This field is required"
              cancel = true
          }else if verifyPassword.text != password.text {
              verifyPasswordError.text = "Passwords do not match"
              cancel = true
          }else{
            
            cancel = false
            self.firebaseSignUp(email: emailAddress.text!, passowrd: verifyPassword.text!)
        }
    }
    
    @objc func firebaseSignUp(email:String,passowrd:String){
        
        self.indicatorViewStart()
        Auth.auth().createUser(withEmail: email, password: passowrd) { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "personalDetails", sender: self)
                self.indicatorViewStop()
            }else{
                self.displayAlertMessage(title: "Something Is Wrong", message: error!.localizedDescription)
            }
        }
    }

    
    @objc func displayAlertMessage(title:String , message:String){
              let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alertController, animated: true, completion: nil)
              self.indicatorViewStop()
          }
       
      @objc func signUp() {
       attemSignUp()
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
