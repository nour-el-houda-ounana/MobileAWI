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
    @State var responsable : String = ""
    
    @State var matSpec : String = ""
    @State var matDress : String = ""
    
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
                    TextField("Nom du responsable", text: $responsable)
                        .onSubmit {
                            liste.listeFichesVM[index].updateRespo(name: responsable)
                        }
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
                    TextField("Nom du responsable", text: $matSpec)
                        .onSubmit {
                            liste.listeFichesVM[index].updateMatSpec(name: matSpec)
                        }
                    
                }
                
                Section(header: Text("Matériel de dressage")) {
                    TextField("Nom du responsable", text: $matDress)
                        .onSubmit {
                            liste.listeFichesVM[index].updateMatDress(name: matDress)
                        }
                }
                
            }
            .navigationTitle("📝 Modifier la fiche")
            .padding()
            .onAppear {
                self.nom = liste.listeFichesVM[index].model.intitule
                self.responsable = liste.listeFichesVM[index].model.responsable
                self.matSpec = liste.listeFichesVM[index].model.materielSpes
                self.matDress = liste.listeFichesVM[index].model.materielDress
                
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
