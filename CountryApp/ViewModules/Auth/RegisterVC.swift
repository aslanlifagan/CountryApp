//
//  RegisterVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 23.12.22.
//


import UIKit

class RegisterVC: BaseVC {
    lazy var navigation: NavigationBarView = {
        let nav = NavigationBarView()
        nav.title = "Register"
        return nav
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nameField: TextFieldView = {
        let view = TextFieldView(placeholder: "Name")
        view.infoActive = "Enter your Name"
        view.error = "* Please check your Name"
        view.delegate = self
        return view
    }()
    lazy var surnameField: TextFieldView = {
        let view = TextFieldView(placeholder: "Surname")
        view.infoActive = "Enter your Surname"
        view.error = "* Please check your Surname"
        view.delegate = self
        return view
    }()
    
    lazy var usernameField: TextFieldView = {
        let view = TextFieldView(placeholder: "Username")
        view.infoActive = "Enter your username"
        view.error = "* Please check your username"
        view.delegate = self
        return view
    }()
    
    lazy var emailField: TextFieldView = {
        let view = TextFieldView(placeholder: "E-mail")
        view.infoActive = "Enter your e-mail"
        view.error = "* Please check your e-mail"
        view.textField.keyboardType = .emailAddress
        view.delegate = self
        return view
    }()
    
    lazy var phoneNumberField: TextFieldView = {
        let view = TextFieldView(placeholder: "Phone")
        view.infoActive = "Enter your phone"
        view.error = "* Please check your phone"
        view.textField.keyboardType = .numberPad
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
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameField, surnameField, usernameField, emailField, phoneNumberField, passwordField])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
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
    
    
    override func setupView() {
        super.setupView()
        view.addSubview(navigation)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.addSubview(submitButton)
    }
    override func setupLabels() {
        super.setupLabels()
    }
    override func setupAnchors() {
        super.setupAnchors()
        navigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,
                          padding: .init(top: 0, leading: 0, trailing: 0), size: .init(width: 0, height: 84))
        
        scrollView.anchor(top: navigation.bottomAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor,padding: .init(top: 24, leading: 0, bottom: 0, trailing: 0))
        contentView.fillSuperview()
        contentView.anchorWidth(to: self.view)
        stackView.fillSuperview(padding: .init(top: 12, leading: 12, bottom: -12, trailing: -12))
        submitButton.anchor(leading: view.leadingAnchor,
                            bottom: view.layoutMarginsGuide.bottomAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(leading: 24,bottom: 0,trailing: -24),size: .init(width: 0, height: 56))
    }
    
    @objc func submitButtonClicked() {
        let  name = nameField.text ?? "", surname = surnameField.text ?? "", username = usernameField.text ?? "", email = emailField.text ?? "", phone = phoneNumberField.text ?? "", pass = passwordField.text ?? ""
        
        if name.isEmpty {
            showMessage("Name is required")
            return
        }
        if surname.isEmpty {
            showMessage("Surname is required")
            return
        }
        if username.isEmpty {
            showMessage("Username is required")
            return
        }
        if email.isEmpty {
            showMessage("Email is required")
            return
        }
        if phone.isEmpty {
            showMessage("Phone is required")
            return
        }
        if pass.isEmpty {
            showMessage("Password is required")
            return
        }
//        let body:[String: Any] = [
//            "name": name,
//            "surname": surname,
//            "username": username,
//            "email": email,
//            "phone": phone,
//            "password": pass
//        ]
        let user =  User(name: name, surname: surname, username: username, email: email, phone: phone, password: pass)
        DefaultsStorage.setUser(user: user)
        popVC(animated: true)
    }
}
extension RegisterVC: TextFieldViewDelegate, UITextFieldDelegate {
    func textFieldViewDidBeginEditing(_ textFieldView: TextFieldView) {
    }
    func textFieldViewDidEndEditing(_ textFieldView: TextFieldView) {
    }
    func textFieldViewChangedEditing(_ textFieldView: TextFieldView) {
    }
}
