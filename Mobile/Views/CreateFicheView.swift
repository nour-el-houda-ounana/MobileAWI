//
//  CreateFicheView.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI

struct CreateFicheView: View {
        
    @ObservedObject
    var categories = CatFicheVM()
    
    @ObservedObject
    var listeFiches = listeFichesVM()
    
    @State var intitule : String = ""
    @State var responsable : String = ""
    @State var couverts : Int = 1
    @State var matSpes : String = ""
    @State var matDress : String = ""
    @State var categorie : String = ""

    
    var body: some View {

        NavigationView {
            Form {
                Section(header: Text("Intitulé")) {
                    TextField("Nom de la recette", text: $intitule)
                }
                
                Section(header: Text("Responsable")) {
                    TextField("Nom de la recette", text: $responsable)
                }
                
                Section(header: Text("Catégorie")) {
                    Picker("Catégories", selection: $categorie){
                        Text("Dessert").tag(FicheCatVM.Dessert.rawValue)
                        Text("Plat").tag(FicheCatVM.Plat.rawValue)
                        Text("Accompagnement").tag(FicheCatVM.Accompagnement.rawValue)
                        Text("Entrée").tag(FicheCatVM.Entrée.rawValue)
                    }
                    .pickerStyle(.menu)
                }

                Section(header: Text("Nombre de couverts")) {
                    Stepper("\(couverts) ",value: $couverts,in: 1...100, step : 1);
                    
                }
                
                Section(header: Text("Matériel spécifique")) {
                    TextField("Matériel spécifique", text: $matSpes)
                    
                }
                
                Section(header: Text("Matériel de dressage")) {
                    TextField("Matériel dressage", text: $matDress)
                    
                }
                
                Button("Valider"){
                    listeFiches.push(fiche: FicheVM(from: Fiche(intitule: intitule, responsable: responsable, couverts: couverts, categorie: categorie, materielSpes: matSpes, materielDress: matDress)))
                    
                }
                .frame(width: 140, height: 30, alignment: .center)
                .foregroundColor(.orange)
                .background(.black)
                .cornerRadius(16)
                .disabled(intitule.isEmpty)
                
                
                /*NavigationLink(destination: HomeView(), label: {
                         Button("Valider"){
                             listeFiches.push(fiche: FicheVM(from: Fiche(intitule: intitule, responsable: responsable, couverts: couverts, categorie: categorie, materielSpes: matSpes, materielDress: matDress)))
                             
                         }
                         .frame(width: 140, height: 30, alignment: .center)
                         .foregroundColor(.orange)
                         .background(.black)
                         .cornerRadius(16)
                         .disabled(intitule.isEmpty)
                     
                })*/

                
            }
            .navigationTitle("➕ Créez votre fiche")
            .padding()
                       
        }
        
    }
}

struct CreateFicheView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFicheView()
    }
}
