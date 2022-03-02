//
//  ContentView.swift
//  Mobile
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            CategoriesView()
                .tabItem {
                    Label("Catégories", systemImage: "list.star")
                }

           CreateFicheView()
                .tabItem {
                    Label("Nouveau", systemImage: "plus")
                }

            StockView()
                .tabItem {
                    Label("Stock", systemImage: "bag.fill")
                }
                        
           CoutsView()
                .tabItem{
                    Label("Couts", systemImage: "eurosign.circle")
                }
            
            CommandeView()
                .tabItem{
                    Label("Commande", systemImage: "barcode.viewfinder")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
