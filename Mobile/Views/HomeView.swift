//
//  HomeView.swift
//  Mobile
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                listeFichesView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
