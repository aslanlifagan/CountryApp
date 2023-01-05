//
//  CountryTableCell.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit

final class CountryTableCell: UITableViewCell {
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
//    lazy var dateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .blueGrey
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
//        label.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
//        return label
//    }()
//
//    lazy var amountLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .blueGrey
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textAlignment = .right
//        return label
//    }()
//
//    lazy var descLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .cerise
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textAlignment = .right
//        return label
//    }()
//
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        addSubview(nameLabel)
        nameLabel.centerInSuperview()
    }
    
    func configureCell(item: CountryElement) {
        nameLabel.text = item.name?.common
    }
}
