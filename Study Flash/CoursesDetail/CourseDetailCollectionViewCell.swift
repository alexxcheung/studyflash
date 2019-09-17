//
//  CourseDetailCollectionViewCell.swift
//  Study Flash
//
//  Created by 李宇恒 on 13/6/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    weak var textLabel: UILabel!
    weak var statusImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let textLabel = UILabel(frame: .zero)
        textLabel.textAlignment = .center
        //        textLabel.font = .systemFont(ofSize: 20)
        //        textLabel.textColor = .gray
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel = textLabel
        
        
        //        let statusImage = UIImageView(image: UIImage(named: "Correct"))
        let statusImage = UIImageView()
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        self.statusImage = statusImage
        
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        //                stackView.spacing = 16.0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(statusImage)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            //            textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            //            textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            //            textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            statusImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    
    
    
}

