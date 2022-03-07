//
//  loginView.swift
//  Mobile
//
//  Created by m1 on 06/03/2022.
//

import SwiftUI

struct loginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var logVM : loginVM
    
    var body: some View {

        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Bienvenue chez")
                  .font(.largeTitle).foregroundColor(Color.black)
                  .padding([.top, .bottom], 40)
                
                Image("OcToBouffe")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                
                Spacer().frame(height: 40)

                TextField("Email", text: self.$email)
                  .padding()
                  .background(Color.orange)
                  .cornerRadius(20.0)
                
                SecureField("Password", text: self.$password)
                  .padding()
                  .background(Color.orange)
                  .cornerRadius(20.0)
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    
                    guard !email.isEmpty , !password.isEmpty else {
                        return
                    }
                    
                    logVM.logIn(email: email, mdp: password)
                    
                }) {
                  Text("Se connecter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(15.0)
                }
            }
            .padding([.leading, .trailing], 27.5)
            
        }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
