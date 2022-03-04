//
//  EtapeCreationView.swift
//  Mobile
//
//  Created by m1 on 03/03/2022.
//

import SwiftUI
import CoreMIDI

struct multiSelect : View {
    
    var body : some View {
        Text("Test")
    }
    
}

struct EtapeCreationView: View {
    
    @ObservedObject
    var fiches = listeFichesVM()
    
    @ObservedObject
    var listeIngreds = listeIngredsVM()
    
    var index : Int
        
    @State var nom : String = ""
    @State var temps : Int = 0
    @State var description : String = ""
    
    @State var chercher = ""
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    var searchListe : [ingredVM] {
           if chercher.isEmpty {
               return listeIngreds.liste
           } else {
               return listeIngreds.searchIngredientByName(nom: chercher)
           }
    }
    
    var ingredients : [Ingredient] = []
    @State private var selectedIngreds = Set<String>()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nom de l'étape ")) {
                    TextField("Nom de l'étape", text: $nom)
                }
                
                Section(header: Text("Temps de réalisation (en min) ")) {
                    TextField("Temps de réalisation ", value: $temps, formatter : formatter)
                }
                
                Section(header: Text("Description")) {
                    TextField("Description ", text: $description)
                }
                
                Section(header: Text("Ingrédients")) {
                    List {
                        ForEach(Array(searchListe.enumerated()), id: \.element.model.id){ index, item in
                            VStack {
                                Text("\(item.name)")
                            }
                        }
                    }
                    .searchable(text: $chercher, prompt: "Chercher un ingrédient")
                }
                
                Button("Valider"){
                    //here
                    let step = EtapeFiche(nom: nom, temps: temps, description: description, ingredients: ingredients)
                    fiches.addEtape(idFiche: index, etape: step)
                    
                }
                .frame(width: 140, height: 30, alignment: .center)
                .foregroundColor(.orange)
                .background(.black)
                .cornerRadius(16)
                .disabled(nom.isEmpty && temps == 0 && description.isEmpty)

                
            }
            .navigationTitle("➕ Ajouter une étape")
            .padding()

        }
        
    }
}

struct EtapeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        let liste = listeFichesVM()
        EtapeCreationView(fiches: liste, index: 0)
    }
}
