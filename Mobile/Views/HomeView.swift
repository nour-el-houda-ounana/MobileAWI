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
                /*Image("OcToBouffe")
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(height: 300)
                     .background(LinearGradient(gradient:  Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))*/

                listeFichesView()

            }
            //.ignoresSafeArea(.container, edges: .top)
            
        }
        .navigationViewStyle(.stack)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
