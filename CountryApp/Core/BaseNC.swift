//
//  BaseNC.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 19.12.22.
//

import UIKit

class BaseNC: UINavigationController {

    var onFinish: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
    }
}
