//
//  settingLauncher.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 26/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

//
//  settingLaucher.swift
//  Pet's Heaven
//
//  Created by Tushar  yadav on 08/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit

class SettingObject: NSObject {
    let name:String
    let imageName:String
    
    init(name:String , imageName:String){
        self.name = name
        self.imageName = imageName
    }
}

class settingLauhcher: NSObject , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
   
    
    
    let blackView = UIView()
    let cellId = "cellId"
    let collectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let cellHeight:CGFloat = 50
    var covid19Update: covid19UpdatesBottomNav?
    
    let settings:[SettingObject] = {
        
        return [SettingObject(name: "Logout", imageName: "logout_icon"), SettingObject(name: "Cancle", imageName: "cancleicon")]
    }()

    @objc func showSettings(){
        if let window = UIApplication.shared.windows.first{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSetting)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height:CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                              self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    @objc func dismissSetting(){
           UIView.animate(withDuration: 0.5, animations: {
               self.blackView.alpha = 0
            if let window = UIApplication.shared.windows.first{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
           })
       }
    
    override init() {
        super .init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(settingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! settingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            UIView.animate(withDuration: 0.5, animations: {
                          self.blackView.alpha = 0
                       if let window = UIApplication.shared.windows.first{
                           self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                       }
                       
                      })
            
        }, completion: {(finish : Bool) in
            
            if setting.name == "Logout"{
                self.covid19Update?.logout()
            }
        })
        print(setting.name)
    }
}
