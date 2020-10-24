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


class EntranceInteractor { }

extension EntranceInteractor: EntranceInteractorProtocol {
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
    
    func signInAccount(_ email: String, _ password: String, completion: @escaping(_ error: Error?) -> ()) {
        // TODO: - enter in account
        completion(nil)
    }
}
