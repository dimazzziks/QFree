//
//  RegistrationViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

protocol RegistrationViewProtocol: class {

}

class RegistrationViewController: BaseViewController {
    public var presenter: RegistrationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}




extension RegistrationViewController: RegistrationViewProtocol {
    
}
