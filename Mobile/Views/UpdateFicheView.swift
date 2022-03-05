//
//  UpdateFicheView.swift
//  Mobile
//
//  Created by m1 on 04/03/2022.
//

import SwiftUI

struct UpdateFicheView: View {
    
    @ObservedObject
    var liste : listeFichesVM
    
    var index : Int
    
    @State var nom : String = ""
    
    var body: some View {        
        NavigationView {
            Form {
                Section(header: Text("Intitulé")) {
                    TextField("Nom de la recette", text: $nom)
                        .onSubmit {
                            liste.listeFichesVM[index].updateName(name: nom)
                        }
                }
                
                Section(header: Text("Responsable")) {
                    Text("\(liste.listeFichesVM[index].model.responsable)")
                }
                
                Section(header: Text("Catégorie")) {
                    /*Picker("Catégories", selection: $categorie){
                        Text("Dessert").tag(FicheCatVM.Dessert.rawValue)
                        Text("Plat").tag(FicheCatVM.Plat.rawValue)
                        Text("Accompagnement").tag(FicheCatVM.Accompagnement.rawValue)
                        Text("Entrée").tag(FicheCatVM.Entrée.rawValue)
                    }
                    .pickerStyle(.menu)*/
                }

                Section(header: Text("Nombre de couverts")) {
                    //Stepper("\(couverts) ",value: $couverts,in: 1...100, step : 1);
                    
                }
                
                Section(header: Text("Matériel spécifique")) {
                    //TextField("Matériel spécifique", text: $matSpes)
                    
                }
                
                Section(header: Text("Matériel de dressage")) {
                    //TextField("Matériel dressage", text: $matDress)
                }
                
            }
            .navigationTitle("📝 Modifier la fiche")
            .padding()
            .onAppear {
                self.nom = liste.listeFichesVM[index].model.intitule
                
            }
        }
        
    }
}

struct UpdateFicheView_Previews: PreviewProvider {
    static var previews: some View {
        let x = listeFichesVM()
        UpdateFicheView(liste: x, index: 0)
    }
}
