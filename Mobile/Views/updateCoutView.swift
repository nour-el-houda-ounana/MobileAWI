//
//  updateCoutView.swift
//  Mobile
//
//  Created by m1 on 03/03/2022.
//

import SwiftUI

struct updateCoutView: View {
    
    @ObservedObject
    var listeCouts : coutsVM
    
    var index : Int

    @State var activer : Bool = true
    @State var personnel : Double = 0
    @State var fluide : Double = 0
    @State var coefficient : Int = 0
    
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    var body: some View {
        
    NavigationView {
        VStack {
            Form {
                Section(header: Text("Coût de personnel (€/h)")) {
                    TextField("nom", value: $personnel, formatter: formatter)
                        .onSubmit {
                            listeCouts.updatePersonnel(idModif: index, cout: personnel)
                        }
                }
                
                Section(header: Text("Coût de fluide (€/h)")) {
                    TextField("nom", value: $fluide, formatter: formatter)
                }
                
                Section(header: Text("Coefficient multiplicateur (%) ")) {
                    TextField("nom", value: $coefficient, formatter: formatter)
                }
                
                Section(header: Text("Coût de personnel ")) {
                    Toggle(isOn: $activer) {
                        Text("Coût d'assaisonement ( 5% ) ")
                    }
                }
                
            }
                    
        }
        .navigationTitle("💰 Modifier les coûts")
        .onAppear {
            self.personnel = listeCouts.model[index].personnel
            self.fluide = listeCouts.model[index].fluide
            self.coefficient = listeCouts.model[index].coeffMultip
            self.activer = listeCouts.model[index].assaisonement
        }
        
    }
        
        
    }
}

struct updateCoutView_Previews: PreviewProvider {
    static var previews: some View {
       // let liste = coutsVM()
        //updateCoutView(listeCouts: liste, index: 0)
        Text("")
    }
}
