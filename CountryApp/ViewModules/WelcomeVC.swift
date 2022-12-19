//
//  WelcomeVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit

class WelcomeVC: BaseVC {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var leftSideView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainOrange
        view.roundBottomRightCorner(radius: 120)
        return view
    }()
    
    lazy var rightSideView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        view.roundBottomLeftCorner(radius: 120)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Welcome\nmy World"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var emailField: TextFieldView = {
        let view = TextFieldView(placeholder: "Email")
        view.infoActive = "Enter your e-mail"
        view.textField.keyboardType = .emailAddress
        view.delegate = self
        view.textField.becomeFirstResponder()
        return view
    }()
    
    lazy var passwordField: TextFieldView = {
        let view = TextFieldView(placeholder: "Password")
        view.infoActive = "Enter your password"
        view.error = "* Please check your password"
        view.isSecureTextEntry = true
        view.validation = TextFieldValidation(min: 6, max: 35)
        view.delegate = self
        view.textField.isUserInteractionEnabled = true
        view.textField.delegate = self
        view.textField.returnKeyType = UIReturnKeyType.done
        view.textField.enablesReturnKeyAutomatically = true
        return view
    }()
    
    lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 6
        button.height = 56
        button.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not Registered ?", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [submitButton, registerButton])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = .systemGray4
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(leftSideView)
        contentView.addSubview(rightSideView)
        leftSideView.addSubview(titleLabel)
        contentView.addSubview(fieldStackView)
        view.addSubview(buttonStackView)

    }
    override func setupLabels() {
        super.setupLabels()
    }
    override func setupAnchors() {
        super.setupAnchors()
        scrollView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
        contentView.fillSuperview()
        contentView.anchorWidth(to: self.view)
        leftSideView.anchorSuperview(top: true,
                                     leading: true,
                                     padding: .init(top: -48,
                                                    leading: 0),
                                     size: .init(
                                        width: UIScreen.main.bounds.width*0.6,
                                        height: UIScreen.main.bounds.height*0.4))
        rightSideView.anchorSuperview(top: true,
                                     trailing: true,
                                     padding: .init(top: -48,
                                                    trailing: 0),
                                     size: .init(
                                        width: UIScreen.main.bounds.width*0.6,
                                        height: UIScreen.main.bounds.height*0.35))
        
        titleLabel.centerYToSuperview()
        titleLabel.anchor(leading: leftSideView.leadingAnchor, padding: .init(leading: 8))
        fieldStackView.anchor(top: leftSideView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: 24,
                                        leading: 24,
                                        bottom: -24,
                                        trailing: -24))
        submitButton.anchorSize(.init(width: 0, height: 56))
        buttonStackView.anchor( leading: view.leadingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(leading: 24, bottom: 0, trailing: -24))
        
    }
    @objc func submitButtonClicked() {
        print("submitButtonClicked")
    }
    @objc func registerButtonClicked() {
        print("registerButtonClicked")
    }
    
}
extension WelcomeVC: TextFieldViewDelegate, UITextFieldDelegate {
    func textFieldViewDidBeginEditing(_ textFieldView: TextFieldView) {
        print("textFieldViewDidBeginEditing")
    }
    
    func textFieldViewDidEndEditing(_ textFieldView: TextFieldView) {
        print("textFieldViewDidEndEditing")
    }
    
    func textFieldViewChangedEditing(_ textFieldView: TextFieldView) {
        print("textFieldViewChangedEditing")
    }
}
