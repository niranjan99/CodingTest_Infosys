//
//  DataTableViewCell.swift
//  CodingTest_Infosys
//
//  Created by Niranjan on 03/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import UIKit

final class DataCell: UITableViewCell {
 private var myViewHeightConstraint: NSLayoutConstraint!

    /* Set data to the cell. */
 internal var setData: ListModel? {
           didSet {
               guard let contactItem = setData else {return}
               if let name = contactItem.title {
                   profileImage.image = UIImage(named: name)
                   nameLabel.text = name
               }
                if let imageURL = contactItem.imageHref {
                    profileImage.downloadImageFromURL(imageURL) } else {
                     profileImage.image = UIImage(named: "placeholder")
                 }
               if let desc = contactItem.description {
                   detailedLabel.text = desc
               }
        }
       }
        /* Arrange views in the cell*/
   private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
    if #available(iOS 13.0, *) {
        view.backgroundColor = .tertiarySystemBackground
    } else {
        // Fallback on earlier versions
        view.backgroundColor = UIColor.groupTableViewBackground
    }
        return view
    }()
     /*Initialise the image view*/
   private let profileImage: UIImageView = {
        let img = UIImageView()
       img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
      /*Initialise name label*/
   private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = .brown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     /*Initialise detail label*/
   private let detailedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor =  .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(profileImage)
    addSubview(nameLabel)
    addSubview(detailedLabel)

    /*Set Constraints to views in cell*/
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    profileImage.topAnchor.constraint(equalTo: detailedLabel.bottomAnchor, constant: 0).isActive = true
    profileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
    profileImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    profileImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
    profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    profileImage.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
    nameLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true

    detailedLabel.translatesAutoresizingMaskIntoConstraints = false
    detailedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    detailedLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    detailedLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
    detailedLabel.bottomAnchor.constraint(equalTo: detailedLabel.bottomAnchor, constant: 0).isActive = true
    detailedLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
