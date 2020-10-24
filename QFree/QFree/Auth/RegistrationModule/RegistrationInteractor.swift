//
//  RegistrationInteractor.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import Foundation

protocol RegistrationInteractorProtocol {
    func emailIsValid(_ email: String?) -> Bool
    func passwordIsValid(_ password: String?) -> Bool
    func createNewAccount(_ email: String, _ password: String, completion: @escaping(_ error: Error?) -> ())
}


class RegistrationInteractor {
    let authValidator: AuthValidatorProtocol!
    init(authValidator: AuthValidatorProtocol) {
        self.authValidator = authValidator
    }
}

extension RegistrationInteractor: RegistrationInteractorProtocol {
    func emailIsValid(_ email: String?) -> Bool {
        return authValidator.emailIsValid(email)
    }
    
    func passwordIsValid(_ password: String?) -> Bool {
        return authValidator.passwordIsValid(password)
    }
    
    func createNewAccount(_ email: String, _ password: String, completion: @escaping (Error?) -> ()) {
        // TODO: - create account
        completion(nil)
    }
}
