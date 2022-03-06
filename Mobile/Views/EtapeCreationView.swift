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
        
    @State var chercherFiche = ""

    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    
    var searchFiche : [FicheVM] {
           if chercherFiche.isEmpty {
               return fiches.listeFichesVM
           } else {
               return fiches.searchFicheByName(nom: chercherFiche)
           }
    }
    
    
    var ingredients : [Ingredient] = []

    @State var autre : Bool = false
    
    @State var etapes : [String] = []

    var body: some View {
        NavigationView {
            VStack {
                    //Lister les fiches existantes
                    List {
                        ForEach(Array(searchFiche.enumerated()), id: \.element.model.id){ index, item in
                            MultiSelectRow(title: item.intitule, isSelected: self.etapes.contains(item.intitule) ) {
                                if self.etapes.contains(item.intitule) {
                                    self.etapes.removeAll(where: { $0 == item.intitule })
                                }
                                else {
                                    self.etapes.append(item.intitule)
                                }
                            }
                        }
                    }
                    .searchable(text: $chercherFiche, prompt: "Chercher une fiche")
            }
            .navigationTitle("➕ Ajouter une étape")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Valider") {
                        self.fiches.addEtapeToFiche(idFiche: index, etapes: etapes)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Autre") {
                        autre = true
                    }.alert("Pour Créer une autre étape \n veuillez créer une nouvelle fiche", isPresented: $autre) {
                        Button("OK", role: .cancel) { }
                    }
                }
            }

        }

    }
}

// Multiple Selection
struct MultiSelectRow: View {
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




struct EtapeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        let liste = listeFichesVM()
        EtapeCreationView(fiches: liste, index: 0)
    }
}
