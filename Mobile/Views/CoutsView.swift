//
//  CoutsView.swift
//  Mobile
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI
import Firebase
        
struct CoutsView : View {
    
    @State var activer : Bool = false
    
    var body: some View {
            
        NavigationView {
            VStack {
                VStack(alignment : .leading) {
                            Text("Cout de personnel : ")
                            Text("Couts de fluide : ")
                            Text("Coefficient multiplicateur : ")
                            Toggle(isOn: $activer) {
                                Text("Cout Assaisonement ( 5% ) ")
                            }
                        }
                        .padding(20)
                        
                        Spacer().frame(height : 60)
                        
                        Button("Modifier"){
                            //fiche.addFiche(intitule: intitule, responsable: responsable, couverts: couverts, materielSpec: matSpes, materielDress: matDress)
                                //NavigationLink
                        }
                        .frame(width: 140, height: 30, alignment: .center)
                        .foregroundColor(.orange)
                        .background(.black)
                        .cornerRadius(16)
                        
                    }
                    .navigationTitle("💰 Gestion des couts")
                   
                    
        }
    }
}
        

struct CoutsView_Previews: PreviewProvider {
    static var previews: some View {
        CoutsView()
    }
}
