//
//  CoutsView.swift
//  Mobile
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI
import Firebase
        
struct CoutsView : View {
    
    @StateObject
    var listeCouts : coutsVM = coutsVM()
    
    @State
    var activer : Bool = false
    
    @State
    var personnel : Double = 0
    
    @State
    var fluide : Double = 0
    
    @State
    var coefficient : Int = 0
    
    var alwaysDisable : Bool = true
    
        
    var body: some View {
            
        NavigationView {
            VStack {
                VStack(alignment : .leading) {
                    Text("Cout de personnel : \(personnel,specifier: "%.2f") €/h")
                    Text("Couts de fluide : \(fluide,specifier: "%.2f") €/MH")
                    Text("Coefficient multiplicateur : \(coefficient)% ")
                    Toggle(isOn: $activer) {
                        Text("Cout Assaisonement ( 5% ) ")
                    }
                    .disabled(alwaysDisable == true)
                }
                .padding(20)
                    
                Spacer().frame(height : 60)
                        
                Button("Modifier"){
                    //Modification
                    
                }
                .frame(width: 140, height: 30, alignment: .center)
                .foregroundColor(.orange)
                .background(.black)
                .cornerRadius(16)
                        
            }
            .navigationTitle("💰 Gestion des couts")
                    
        }
        .onAppear {
            self.personnel = self.listeCouts.model[0].personnel
            self.fluide = self.listeCouts.model[0].fluide
            self.coefficient = self.listeCouts.model[0].coeffMultip
            self.activer = self.listeCouts.model[0].assaisonement
        }
    }
}
        

struct CoutsView_Previews: PreviewProvider {
    static var previews: some View {
        CoutsView()
    }
}
