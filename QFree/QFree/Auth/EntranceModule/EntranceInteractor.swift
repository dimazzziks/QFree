//
//  EntranceInteractor.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation

protocol EntranceInteractorProtocol {
    func emailIsValid(_ email: String?) -> Bool
    func passwordIsValid(_ password: String?) -> Bool
    func signInAccount(_ email: String, _ password: String, completion: @escaping(_ error: Error?) -> ())
}


class EntranceInteractor {
    let authValidator: AuthValidatorProtocol!
    init(authValidator: AuthValidatorProtocol) {
        self.authValidator = authValidator
    }
}

extension EntranceInteractor: EntranceInteractorProtocol {
    func emailIsValid(_ email: String?) -> Bool {
        return authValidator.emailIsValid(email)
    }
    
    func passwordIsValid(_ password: String?) -> Bool {
        return authValidator.passwordIsValid(password)
    }
    
    func signInAccount(_ email: String, _ password: String, completion: @escaping(_ error: Error?) -> ()) {
        // TODO: - enter in account
        completion(nil)
    }
}
