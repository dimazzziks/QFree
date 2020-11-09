//
//  EmailConfirmationInteractor.swift
//  QFree
//
//  Created by User on 09.11.2020.
//

import Foundation
import FirebaseAuth

protocol EmailConfirmationInteractorProtocol {
    func confirmEmail(completion: @escaping ()->())
    func resendVerificationEmail()
    func deleteUser(completion: @escaping ()->())
}

class EmailConfirmationInteractor : EmailConfirmationInteractorProtocol{
    
    func confirmEmail(completion: @escaping () -> ()){
        let user = Auth.auth().currentUser
        user?.reload(completion: {error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                completion()
            }
        })
    }
    
    func resendVerificationEmail(){
        let user = Auth.auth().currentUser!
        user.sendEmailVerification(completion: { (error) in
            if let error = error{
                print(error.localizedDescription)
            }
        })
    }
    
    func deleteUser(completion : @escaping ()->()){
        Auth.auth().currentUser?.delete(completion: { (error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                do{
                    try Auth.auth().signOut()
                } catch{
                    print(error.localizedDescription)
                }
                completion()
            }
        })
    }
}
