//
//  EntranceInteractor.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation
import FirebaseAuth

protocol EntranceInteractorProtocol {
    func emailIsValid(_ email: String?) -> Bool
    func passwordIsValid(_ password: String?) -> Bool
    func signInAccount(_ email: String, _ password: String, completion: @escaping(_ error: AuthError?) -> ())
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
    
    func signInAccount(_ email: String, _ password: String, completion: @escaping(_ error: AuthError?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            guard error == nil else {
                completion(.signInError)
                return
            }
            print("USER SIGNED IN:", authDataResult?.user.email ?? "nil")
            completion(nil)
        }
    }
}
