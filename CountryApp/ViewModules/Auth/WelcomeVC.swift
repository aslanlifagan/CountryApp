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
        view.roundBottomRightCorner(120)
        return view
    }()
    
    lazy var rightSideView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        view.roundBottomLeftCorner(120)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome..."
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var emailField: TextFieldView = {
        let view = TextFieldView(placeholder: "E-mail")
        view.infoActive = "Enter your e-mail"
        view.error = "* Please check your e-mail"
        view.textField.keyboardType = .emailAddress
//        view.text = DefaultsStorage.getUser()?.email
        view.delegate = self
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
//        view.text = DefaultsStorage.getUser()?.password
        return view
    }()
    
    lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var submitButton: SubmitButton = {
        let button = SubmitButton()
        button.bgColor = .mainGreen
        button.titleColor = .white
        button.title = "Sign In"
        button.click = { [weak self] in
            guard let self = self else {return}
            self.submitButtonClicked()
        }
        return button
    }()
    
    lazy var registerButton: SubmitButton = {
        let button = SubmitButton()
        button.bgColor = .clear
        button.titleColor = .black
        button.title = "Not Registered ?"
        button.click = { [weak self] in
            guard let self = self else {return}
            self.registerButtonClicked()
        }
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [submitButton, registerButton])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override func setupView() {
        super.setupView()
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
                                     padding: .init(top: -64,leading: 0),
                                     size: .init(width: UIScreen.main.bounds.width*0.6,height: UIScreen.main.bounds.height*0.4))
        rightSideView.anchorSuperview(top: true,
                                      trailing: true,
                                      padding: .init(top: -64,trailing: 0),
                                      size: .init(width: UIScreen.main.bounds.width*0.6,height: UIScreen.main.bounds.height*0.35))
        titleLabel.centerYToSuperview()
        titleLabel.anchor(leading: leftSideView.leadingAnchor, padding: .init(leading: 8))
        fieldStackView.anchor(top: leftSideView.bottomAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: contentView.trailingAnchor,
                              padding: .init(top: 24,leading: 24,bottom: -24,trailing: -24))
        submitButton.anchorSize(.init(width: 0, height: 56))
        buttonStackView.anchor(leading: view.leadingAnchor,
                               bottom: view.layoutMarginsGuide.bottomAnchor,
                               trailing: view.trailingAnchor,
                               padding: .init(leading: 24,bottom: 0,trailing: -24))
    }
    
    @objc func submitButtonClicked() {
        let  email = emailField.text ?? "", pass = passwordField.text ?? ""
        
        if email.isEmpty {
            showMessage("Username is required")
            return
        }
        if pass.isEmpty {
            showMessage("Pass is required")
            return
        }
//        let body:[String: Any] = [
//            "username": usern,
//            "password": pass
//        ]
        if email == DefaultsStorage.getUser()?.email && pass == DefaultsStorage.getUser()?.password {
            AppDelegate.shared.login()
        } else {
            showMessage("yes kimi")
        }
        
    }
    
    @objc func registerButtonClicked() {
        let controller = RegisterVC()
        controller.hidesBottomBarWhenPushed = true
        pushVC(controller, animated: true)
    }
    
}
extension WelcomeVC: TextFieldViewDelegate, UITextFieldDelegate {
    func textFieldViewDidBeginEditing(_ textFieldView: TextFieldView) {
    }
    func textFieldViewDidEndEditing(_ textFieldView: TextFieldView) {
    }
    func textFieldViewChangedEditing(_ textFieldView: TextFieldView) {
        switch textFieldView {
        case emailField:
            if textFieldView.text!.isEmpty || !textFieldView.text!.isEmail {
                textFieldView.isError = true
            } else {
                textFieldView.isError = false
            }
        case passwordField:
            if textFieldView.text!.isEmpty || !textFieldView.validationStatus {
                textFieldView.isError = true
            } else {
                textFieldView.isError = false
            }
        default:
            break
        }
    }
}
