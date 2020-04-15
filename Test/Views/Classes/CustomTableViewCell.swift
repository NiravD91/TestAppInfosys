//
//  CustomTableViewCell.swift
//  Test
//
//  Created by Nirav on 15/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let imageCache = NSCache<NSString, UIImage>()

    var listRows: RowsData? {
        didSet {
            guard let listRowItem = listRows else {
                return
            }
            
            if let strTitle = listRowItem.title {
                titleLabel.text = " \(strTitle) "
            }
            
            if let strDesc = listRowItem.description {
                descriptionLabel.text = " \(strDesc) "
            }
            
            if let imgURL = listRowItem.imageHref {
                if let cachedImage = imageCache.object(forKey: NSString(string: (listRowItem.title ?? ""))) {
                    imageHrefView.image = cachedImage
                } else {
                    if imgURL != GEN_STRINGS.NO_URL {
                        DispatchQueue.global(qos: .background).async {
                            let url = URL(string: (imgURL))
                            let data = try? Data(contentsOf: url!)
                            let image: UIImage = UIImage(data: data!)!
                            
                            DispatchQueue.main.async {
                                self.imageCache.setObject(image, forKey: NSString(string: (listRowItem.title!)))
                                self.imageHrefView.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let imageHrefView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 40
        imgView.clipsToBounds = true
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let lblTitle = UILabel()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    let descriptionLabel: UILabel = {
        let lblDesc = UILabel()
        lblDesc.font = UIFont.boldSystemFont(ofSize: 14)
        lblDesc.textColor =  .white
        lblDesc.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        lblDesc.layer.cornerRadius = 5
        lblDesc.clipsToBounds = true
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        return lblDesc
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imageHrefView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
        
        imageHrefView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        imageHrefView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        imageHrefView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageHrefView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.imageHrefView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
