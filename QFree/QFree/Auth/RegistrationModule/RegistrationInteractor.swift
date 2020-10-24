//
//  RegistrationInteractor.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import Foundation
import FirebaseAuth

protocol RegistrationInteractorProtocol {
    func nameIsValid(_ name: String?) -> Bool
    func emailIsValid(_ email: String?) -> Bool
    func passwordIsValid(_ password: String?) -> Bool
    func createNewAccount(_ email: String, _ password: String, completion: @escaping(_ error: AuthError?) -> ())
}


class RegistrationInteractor {
    let authValidator: AuthValidatorProtocol!
    init(authValidator: AuthValidatorProtocol) {
        self.authValidator = authValidator
    }
}

extension RegistrationInteractor: RegistrationInteractorProtocol {
    func nameIsValid(_ name: String?) -> Bool {
        return authValidator.nameIsValid(name)
    }
    func emailIsValid(_ email: String?) -> Bool {
        return authValidator.emailIsValid(email)
    }
    
    func passwordIsValid(_ password: String?) -> Bool {
        return authValidator.passwordIsValid(password)
    }
    
    func createNewAccount(_ email: String, _ password: String, completion: @escaping (AuthError?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            guard error == nil else {
                print("ERROR: \(error?.localizedDescription ?? "nil")")
                completion(.createUserError)
                return
            }
            print("USER CREATED: \(authDataResult?.user.email ?? "authDataResult?.user.email == nil")")
            completion(nil)
        }
    }
}
