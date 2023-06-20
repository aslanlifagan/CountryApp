//
//  SubmitButton.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 23.12.22.
//

import UIKit

final class SubmitButton: UIButton {
    
    var bgColor: UIColor? {
        didSet {
            buttonView.backgroundColor = bgColor
        }
    }
    
    var title: String? {
        didSet {
            textLabel.text = title
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            textLabel.textColor = titleColor
        }
    }
    
    var click: (() -> ())?
    
    lazy var buttonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
//        view.setupShadow(opacity: 0.3, radius: 16, offset: .init(width: 0, height: 4), color: .lightGray)
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    required init() {
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            alpha = newValue ? 0.5 : 1.0
            super.isHighlighted = newValue
        }
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpInside))
        buttonView.addGestureRecognizer(gesture)
        
        addSubview(buttonView)
        
        buttonView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor ,trailing: trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        buttonView.addSubview(textLabel)
        
        textLabel.anchor(top: buttonView.topAnchor, leading: buttonView.leadingAnchor, bottom: buttonView.bottomAnchor ,trailing: buttonView.trailingAnchor,
        padding: .init(top: 12, left: 12, bottom: -12, right: -12))
        
    }
    
    
    // MARK: - Action
    
    @objc func touchUpInside() {
        self.click?()
    }
}

