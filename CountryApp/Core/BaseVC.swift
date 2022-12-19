//
//  BaseVC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        hideKeyboardWhenTappedAround()
        setupView()
        setupLabels()
        setupAnchors()
    }
    // MARK: - Initialization Functions
    func setupView() {}
    func setupLabels() {}
    func setupAnchors() {}
    
}
extension BaseVC: UIGestureRecognizerDelegate {}
