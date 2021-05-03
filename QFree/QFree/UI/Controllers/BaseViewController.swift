//
//  BaseViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func showNoInternetAlert(_ okAction: (() -> ())?) {
        let alert = UIAlertController(
            title: "Внимание",
            message: "Вы не подключены к интернету",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { _ in
            okAction?()
        })
        present(alert, animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(BaseViewController.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension BaseViewController {
    @objc func keyboardWillAppear() { }
    @objc func keyboardWillDisappear() { }
}
