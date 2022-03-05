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
    
    @ObservedObject
    var listeIngreds = listeIngredsVM()
    
    @State var intitule : String = ""
    @State var responsable : String = ""
    @State var couverts : Int = 1
    @State var matSpes : String = ""
    @State var matDress : String = ""
    @State var categorie : String = ""

    // Etape de base
    @State var description : String = ""
    @State var ingredSelected : [String] = []
    @State var temps : Int = 0
    
    @State var chercher = ""
    
    var searchListe : [ingredVM] {
           if chercher.isEmpty {
               return listeIngreds.liste
           } else {
               return listeIngreds.searchIngredientByName(nom: chercher)
           }
    }
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("--- Informations de base ------  \n \nIntitulé")) {
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
                
                
                Section(header: Text("--- Etape de base ------  \n \nIngrédients")) {
                    List {
                        ForEach(Array(searchListe.enumerated()), id: \.element.model.id){ index, item in
                            
                            MultipleSelectionRow(title: item.name, isSelected: self.ingredSelected.contains(item.name)) {
                                if self.ingredSelected.contains(item.name) {
                                    self.ingredSelected.removeAll(where: { $0 == item.name })
                                }
                                else {
                                    self.ingredSelected.append(item.name)
                                }
                            }
                        }
                    }
                    .searchable(text: $chercher, prompt: "Chercher un ingrédient")
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                }
                
                Section(header: Text("Durée de l'étape (en min)")) {
                    TextField("Durée", value: $temps, formatter : formatter)
                }
                
                //
                
                Section(header: Text("---------------------------- \n \nMatériel spécifique")) {
                    TextField("Matériel spécifique", text: $matSpes)
                }
                
                Section(header: Text("Matériel de dressage")) {
                    TextField("Matériel dressage", text: $matDress)
                    
                }
                
                Button("Valider"){
                    listeFiches.push(fiche: FicheVM(from: Fiche(intitule: intitule, responsable: responsable, couverts: couverts, categorie: categorie,ingredients: ingredSelected,description: description, etape: [], materielSpes: matSpes, materielDress: matDress, temps: temps)))
                    
                }
                .frame(width: 140, height: 30, alignment: .center)
                .foregroundColor(.orange)
                .background(.black)
                .cornerRadius(16)
                .disabled(intitule.isEmpty)
                
            }
            .navigationTitle("➕ Créez votre fiche")
            .padding()
                       
        }
        
    }
}

// Multiple Selection
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct CreateFicheView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFicheView()
    }
}
