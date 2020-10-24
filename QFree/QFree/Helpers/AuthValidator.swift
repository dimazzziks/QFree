//
//  AuthValidator.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import Foundation

protocol AuthValidatorProtocol {
    func emailIsValid(_ email: String?) -> Bool
    func passwordIsValid(_ password: String?) -> Bool
    func nameIsValid(_ name: String?) -> Bool
    func phoneNumberIsValid(_ phoneNumber: String) -> Bool
    func promoCodeIsValid(_ promoCode: String) -> Bool
}

class AuthValidator: AuthValidatorProtocol {
    func emailIsValid(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func passwordIsValid(_ password: String?) -> Bool {
        // TODO: - passport validation
        guard let password = password else {
            return false
        }
        return !password.isEmpty
    }
    
    func nameIsValid(_ name: String?) -> Bool {
        // TODO: - name validation
        return true
    }
    
    func phoneNumberIsValid(_ phoneNumber: String) -> Bool {
        // TODO: - name validation
        return true
    }
    
    func promoCodeIsValid(_ promoCode: String) -> Bool {
        // TODO: - promo code validation
        return true
    }
}
