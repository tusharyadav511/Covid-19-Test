//
//  ViewController.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 24/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var logInViewButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func logInButton(_ sender: Any) {
        logIn()
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        logInViewButton.layer.cornerRadius = 15
        logInViewButton.clipsToBounds = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
          self.performSegue(withIdentifier: "mainBottomNav", sender: nil)
        }
        else
        {
          print("No sign In")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField{
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            textField.resignFirstResponder()
            logIn()
            
        }
        return true
    }
    
    
    func logIn(){
        self.indicatorViewStart()
        if loginTextField.text != "" && passwordTextField.text != ""{
            
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!) { (user, error) in
                 if error == nil{
                    self.userLogIn()
                    
                }else{
                    self.displayAlertMessage(title: "Something Is Wrong", message: error!.localizedDescription)
                }
            }
        }else{
            print("no no no")
            self.displayAlertMessage(title: "Missing Information", message: "You must provide both a email and password")
        }
    }
    
    @objc func displayAlertMessage(title:String , message:String){
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
           self.indicatorViewStop()
       }
       
       @objc func userLogIn(){
          performSegue(withIdentifier: "mainBottomNav", sender: nil)
           self.indicatorViewStop()
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
        
        //Hiii
        
        
      ////Yoyo
       }


}

