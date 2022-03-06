//
//  loginVM.swift
//  Mobile
//
//  Created by m1 on 06/03/2022.
//

import Foundation
import FirebaseAuth

class loginVM : ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var logged : Bool = false
    
    var isLoggedIn : Bool {
        return auth.currentUser != nil
    }
    
    func logIn(email : String , mdp : String) {
        auth.signIn(withEmail: email, password: mdp) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.logged = true
            }
            
        }
    }
    
}
