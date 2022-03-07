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
    
    @State var activer : Bool = false
    @State var personnel : Double = 0
    @State var fluide : Double = 0
    @State var coefficient : Int = 0
    
    var alwaysDisable : Bool = true
    
    @State var update = true
    
    var body: some View {
        NavigationView {
            ForEach(Array(listeCouts.model.enumerated()), id: \.element.id) { index, item in
                VStack {
                    VStack(alignment : .leading) {
                        Text("Coût de personnel : \(item.personnel,specifier: "%.2f") €/h")
                        Text("Coût de fluide : \(item.fluide,specifier: "%.2f") €/h")
                        Text("Coefficient multiplicateur : \(item.coeffMultip)% ")

                        Toggle(isOn: $activer) {
                            Text("Coût d'assaisonement ( 5% ) ")
                        }
                        .disabled(alwaysDisable == true)
                    }
                    .padding(20)
                        
                    Spacer().frame(height : 60)
                            
                    Button("Modifier"){
                        //Modification
                        update = true
                        
                    }
                    .frame(width: 140, height: 30, alignment: .center)
                    .foregroundColor(.orange)
                    .background(.black)
                    .cornerRadius(16)
                            
                }
                .navigationTitle("💰 Gestion des couts")
                .sheet(isPresented: $update) {
                    updateCoutView(listeCouts : listeCouts, index: index)
                }
            }
        }.onAppear{
            listeCouts.getCouts()
        }
        
    }
}
        

struct CoutsView_Previews: PreviewProvider {
    static var previews: some View {
        CoutsView()
    }
}
