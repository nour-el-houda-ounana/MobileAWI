//
//  AppTabView.swift
//  Mobile
//
//  Created by m1 on 07/03/2022.
//

import SwiftUI

struct AppTabView: View {
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

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
