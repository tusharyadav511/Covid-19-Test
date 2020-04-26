//
//  settingCell.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 26/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit

class settingCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            nameLable.textColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    var setting: SettingObject? {
        didSet {
            nameLable.text = setting?.name
            
            if let imageName = setting?.imageName{
                iconImageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Setting"
        lable.font = .systemFont(ofSize: 13)
        return lable
    }()
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting_icon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(nameLable)
        addSubview(iconImageView)
        
        addConstraintWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView , nameLable)
        addConstraintWithFormat("V:|[v0]|", views: nameLable)
        addConstraintWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    }
}
