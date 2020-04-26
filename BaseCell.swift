//
//  BaseCell.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 26/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    @objc func setUpViews(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

class Setting: NSObject {
    let name:String
    let imageName:String
    
    init(name: String, imageName: String){
        self.name = name
        self.imageName = imageName
    }
}

extension UIView{
func addConstraintWithFormat(_ format : String, views : UIView...) {

    var viewsDictionary = [String : UIView]()

    for(index, view) in views.enumerated(){
        let key = "v\(index)"
        view.translatesAutoresizingMaskIntoConstraints = false
        viewsDictionary[key] = view
    }
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))

    }
    
}
