//
//  CustomTableViewCell.swift
//  IosAssignment
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import UIKit

    class CustomTableViewCell: UITableViewCell {
        var namelbl = UILabel()
        var desclbl = UILabel()
        var userImage = UIImageView()
        
        
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            // configure titleLabel
            contentView.addSubview(userImage)
            contentView.addSubview(namelbl)
            contentView.addSubview(desclbl)
            
            userImage.translatesAutoresizingMaskIntoConstraints = false
            namelbl.translatesAutoresizingMaskIntoConstraints = false
            desclbl.translatesAutoresizingMaskIntoConstraints = false
            
            userImage.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant: 12).isActive = true
            userImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
            userImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
            userImage.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
            
            
            namelbl.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12).isActive = true
            namelbl.leftAnchor.constraint(equalTo:userImage.rightAnchor, constant: 8).isActive = true
            namelbl.rightAnchor.constraint(equalTo:contentView.rightAnchor, constant: -8).isActive = true
            namelbl.numberOfLines = 0
            namelbl.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
            
            desclbl.topAnchor.constraint(equalTo: namelbl.bottomAnchor, constant: 8).isActive = true
            desclbl.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 8).isActive = true
            desclbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
            desclbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
            desclbl.numberOfLines = 0
            desclbl.font = UIFont(name: "Avenir-Book", size: 18)
            desclbl.textColor = UIColor.lightGray
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
