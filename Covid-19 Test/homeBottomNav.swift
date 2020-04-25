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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: Any) {
        URLCache.shared.removeAllCachedResponses()
                  
        try! Auth.auth().signOut()
                  
        self.performSegue(withIdentifier: "logout", sender: self)
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
