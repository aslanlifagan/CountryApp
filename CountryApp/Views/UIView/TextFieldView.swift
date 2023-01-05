//
//  TextFieldView.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit

struct TextFieldValidation {
    var min: Int?
    var max: Int?
}

protocol TextFieldViewDelegate {
    func textFieldViewDidBeginEditing(_ textFieldView: TextFieldView)
    func textFieldViewDidEndEditing(_ textFieldView: TextFieldView)
    func textFieldViewChangedEditing(_ textFieldView: TextFieldView)
}

extension TextFieldViewDelegate {
    func textFieldViewDidBeginEditing(_ textFieldView: TextFieldView) {}
    func textFieldViewDidEndEditing(_ textFieldView: TextFieldView) {}
    func textFieldViewChangedEditing(_ textFieldView: TextFieldView) {}
}

final class TextFieldView: UIView {

    var delegate: TextFieldViewDelegate!
    
    
    var fillColor: UIColor = .systemGray3 {
        didSet {
            bodyView.backgroundColor = fillColor
        }
    }
    
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            if isDisable {
                placeholderLabel.text = newValue
            }
            else {
                textField.text = newValue
                if !isActive {
                    if !newValue!.isEmpty {
                        self.floatingAnimate()
                    } else {
                        self.normalAnimate()
                    }
                }
            }
        }
    }
    
    var textColor: UIColor = .mainGreen {
        didSet {
            textField.textColor = textColor
        }
    }
    
    
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    var placeholderColor: UIColor = .mainGreen {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    
    var colorActive: UIColor = .mainGreen
    
    var font: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    var floatingFont: UIFont = UIFont.systemFont(ofSize: 12)
    
    
    var info: String = "" {
        didSet {
            infoLabel.text = info
        }
    }
    
    var infoActive: String = ""
    
    var infoColor: UIColor = .mainGreen {
        didSet {
            infoLabel.textColor = infoColor
        }
    }
    
    var infoFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            infoLabel.font = infoFont
        }
    }
    
    
    var error: String = ""
    
    var errorColor: UIColor = .red
    
    
    var iconButtonImage: UIImage? {
        didSet {
            iconButton.setImage(iconButtonImage, for: .normal)
        }
    }
    
    
    var isActive: Bool = false {
        didSet {
            if isActive {
                self.placeholderLabel.textColor = self.colorActive
                self.bodyView.setupBorder(width: 1, color: self.colorActive)
                self.infoLabel.text = !infoActive.isEmpty ? infoActive : info
                self.infoLabel.textColor = self.colorActive
            }
            else {
                self.placeholderLabel.textColor = self.placeholderColor
                self.bodyView.setupBorder(width: 0, color: .clear)
                self.infoLabel.text = info
                self.infoLabel.textColor = self.infoColor
            }
        }
    }
    
    var isError: Bool = false {
        didSet {
            if !self.isActive {
                infoLabel.text = (isError && !error.isEmpty) ? error : info
                infoLabel.textColor = isError ? errorColor : infoColor
                bodyView.setupBorder(width: isError ? 1 : 0, color: isError ? errorColor : .clear)
            }
            iconView.image = isError ? #imageLiteral(resourceName: "error_icon") : nil
            textFieldTrailingConstraint.constant = isError ? -48 : -16
        }
    }
    
    var isValid: Bool = false {
        didSet {
            iconView.image = isValid ? #imageLiteral(resourceName: "valid-icon") : nil
            textFieldTrailingConstraint.constant = isValid ? -48 : -16
        }
    }
    
    var showIconButton: Bool = false {
        didSet {
            iconButton.isHidden = !showIconButton
            iconView.isHidden = showIconButton
            textFieldTrailingConstraint.constant = showIconButton ? -48 : -16
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var validation: TextFieldValidation?
    
    var validationStatus: Bool = false
    
    var isSelectable: Bool = false {
        didSet {
            tapGesture.isEnabled = isSelectable
            textField.isUserInteractionEnabled = !isSelectable
            iconView.image = isSelectable ? #imageLiteral(resourceName: "drop-down-icon") : nil
        }
    }
    
    var isClickable: Bool = false {
        didSet {
            tapGesture.isEnabled = isClickable
            textField.isUserInteractionEnabled = !isClickable
            iconView.image = nil
        }
    }
    
    var isDisable: Bool = false {
        didSet {
            tapGesture.isEnabled = !isDisable
            textField.isUserInteractionEnabled = !isSelectable
            
            if isDisable {
                placeholderLabel.text = text
                textField.text = ""
                self.normalAnimate()
            }
            else {
                placeholderLabel.text = placeholder
                textField.text = text
                
                if !textField.text!.isEmpty {
                    self.floatingAnimate()
                } else {
                    self.normalAnimate()
                }
            }
        }
    }
    
    var isBlock: Bool = false {
        didSet {
            tapGesture.isEnabled = !isBlock
            textField.isUserInteractionEnabled = !isBlock
            
            textField.textColor = isBlock ? placeholderColor : textColor
        }
    }
    
    
    var iconButtonClick: (() -> ())?
    
    var click: (() -> ())?
    
    
    private lazy var bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = fillColor
        view.layer.cornerRadius = 6
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = placeholderColor
        label.font = font
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = textColor
        textField.font = font
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        //textField.delegate = self
        textField.tintColor = .systemBackground
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldChangedEditing(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = info
        label.textColor = infoColor
        label.font = infoFont
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.addTarget(self, action: #selector(iconButtonTouchUp), for: .touchUpInside)
        return button
    }()
    
    
    private var textFieldTrailingConstraint: NSLayoutConstraint!
    
    private var tapGesture: UITapGestureRecognizer!
    
    
    required init(placeholder: String) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tapGesture.isEnabled = false
        addGestureRecognizer(tapGesture)
        
        addSubview(bodyView)
        bodyView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                        size: .init(width: 0, height: 56))
        
        
        // placeholder
        placeholderLabel.text = placeholder
        bodyView.addSubview(placeholderLabel)
        placeholderLabel.anchor(top: bodyView.topAnchor, leading: bodyView.leadingAnchor, bottom: bodyView.bottomAnchor, trailing: bodyView.trailingAnchor,
                                padding: .init(top: 16, left: 16, bottom: -16, right: -16))
        
        // text field
        addSubview(textField)
        textField.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,
                         padding: .init(top: 16, left: 16, bottom: 0, right: 0),
                         size: .init(width: 0, height: 40))
        
        textFieldTrailingConstraint = textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        textFieldTrailingConstraint.isActive = true
        
        
        // info
        addSubview(infoLabel)
        infoLabel.anchor(top: textField.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 4, left: 16, bottom: 0, right: -16))
        infoLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
        
        
        // icon
        bodyView.addSubview(iconView)
        iconView.anchor(top: bodyView.topAnchor, leading: nil, bottom: nil, trailing: bodyView.trailingAnchor,
                        padding: .init(top: 16, left: 0, bottom: 0, right: -16),
                        size: .init(width: 24, height: 24))
        
        addSubview(iconButton)
        iconButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,
                          padding: .init(top: 12, left: 0, bottom: 0, right: -12),
                          size: .init(width: 32, height: 32))
    }
    
    private func floatingAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.placeholderLabel.font = self.floatingFont
            self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: -14)
        })
    }
    
    private func normalAnimate() {
        UIView.animate(withDuration: 0.2, animations: {
            self.placeholderLabel.font = self.font
            self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    
    // MARK: - Action
    
    @objc func iconButtonTouchUp() {
        iconButtonClick?()
    }
    
    @objc func tapAction() {
        click?()
    }
    
    
    // MARK: - Public
    
    public func fillText() {
        if showIconButton {
            showIconButton = false
        }
        self.floatingAnimate()
    }
    
    
    // MARK: - TextField delegate
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        self.isActive = true
        
        if !textField.hasText {
            if showIconButton {
                showIconButton = false
            }
            self.floatingAnimate()
        }
        
        if let delegate = self.delegate {
            delegate.textFieldViewDidBeginEditing(self)
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        self.isActive = false
        
        if !textField.hasText {
            if iconButtonImage != nil {
                showIconButton = true
            }
            self.normalAnimate()
        }
        
        if let delegate = self.delegate {
            delegate.textFieldViewDidEndEditing(self)
        }
    }

    @objc func textFieldChangedEditing(_ textField: UITextField) {
        if self.validation != nil {
            let count = textField.text!.count
            
            var minStatus: Bool = false
            if let min = self.validation!.min {
                if count >= min {
                    minStatus = true
                }
            } else {
                minStatus = true
            }
            
            var maxStatus: Bool = false
            if let max = self.validation!.max {
                if self.validation!.min == nil {
                    if count == max {
                        maxStatus = true
                    }
                } else {
                    if count <= max {
                        maxStatus = true
                    }
                }
            } else {
                maxStatus = true
            }
            
            self.validationStatus = (minStatus && maxStatus)
        }
        
        if let delegate = self.delegate {
            delegate.textFieldViewChangedEditing(self)
        }
    }
}
