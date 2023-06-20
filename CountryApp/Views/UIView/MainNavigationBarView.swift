//
//  MainNavigationBarView.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit
import Foundation

final class MainNavigationBarView: UIView {
    
    var title: String? {
        didSet {
            textLabel.text = title
        }
    }
        
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    required init() {
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(contentView)
        contentView.fillSuperview()
        contentView.addSubview(textLabel)
        textLabel.centerXToSuperview()
        textLabel.anchor(bottom: contentView.bottomAnchor, padding: .init(bottom: -12))
    }
    
    
    // MARK: - Action
    
    @objc func backButtonClicked() {
        let nav = UIApplication.getPresentedViewController() as! BaseNC
        nav.popViewController(animated: true)
    }
}


