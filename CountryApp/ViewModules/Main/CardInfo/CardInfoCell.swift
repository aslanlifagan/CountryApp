//
//  CardInfoCell.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 12.08.23.
//

import UIKit

final class CardInfoCell: UICollectionViewCell {
    static let ID: String = "CardInfoCell"
    
    lazy var contenView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.setupBorder(width: 1, color: .red)
        return view
    }()
    lazy var iconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.anchorSize(.init(width: 24, height: 24))
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.anchorSize(.init(width: 0, height: 1))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(contenView)
        contenView.fillSuperview()
        
        contenView.addSubview(iconView)
        iconView.anchor(top: contenView.topAnchor, leading: contenView.leadingAnchor,
                        padding: .init(top: 8, left: 16, bottom: 0, right: 0),
                        size: .init(width: 44, height: 44))
        
        iconView.addSubview(iconImage)
        iconImage.centerInSuperview()
        
        
        contenView.addSubview(nameLabel)
        nameLabel.anchor(top: contenView.topAnchor, leading: iconView.trailingAnchor, trailing: contenView.trailingAnchor,
                         padding: .init(top: 8, left: 16, bottom: 0, right: -16))
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        
        
        contenView.addSubview(descLabel)
        descLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor,
                          padding: .init(top: 2, left: 0, bottom: 0, right: -16))
        descLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22).isActive = true
        
        contentView.addSubview(lineView)
        lineView.anchor(
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contenView.trailingAnchor,
            padding: .init(top: 0, left: 92, bottom: 0, right: -16))
        
    }
    
    public func setupData(title: String, desc: String) {
        nameLabel.text = title
        descLabel.text = desc
    }
}

