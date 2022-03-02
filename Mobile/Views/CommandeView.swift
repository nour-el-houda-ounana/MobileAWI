//
//  CommandeView.swift
//  Mobile
//
//  Created by m1 on 16/02/2022.
//


import SwiftUI
import Firebase

struct CommandeView: View {
    
    var body: some View {
        NavigationView {
            Text("Commandes").bold().foregroundColor(.orange).font(.title).navigationTitle("Commande")
        
        }
    }
}

struct CommandeView_Previews: PreviewProvider {
    static var previews: some View {
        CommandeView()
    }
}
